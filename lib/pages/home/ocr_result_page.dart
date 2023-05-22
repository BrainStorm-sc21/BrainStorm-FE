import 'package:brainstorm_meokjang/app_pages_container.dart';
import 'package:brainstorm_meokjang/models/food.dart';
import 'package:brainstorm_meokjang/pages/home/loading_page.dart';
import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:brainstorm_meokjang/utilities/domain.dart';
import 'package:brainstorm_meokjang/utilities/popups.dart';
import 'package:brainstorm_meokjang/widgets/all.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OCRResultPage extends StatefulWidget {
  final String imagePath;
  final String imageType;

  const OCRResultPage({super.key, required this.imagePath, required this.imageType});

  @override
  State<OCRResultPage> createState() => _OCRResultPageState();
}

class _OCRResultPageState extends State<OCRResultPage> {
  List<Food> foods = List.empty(growable: true);
  late Map<int, List<DateTime>> recommendList = {};
  final List<TextEditingController> _foodNameController = [];
  late bool _isLoading = true;
  Map<String, Map<String, Map<String, dynamic>>> ocrResult = {};
  /*
    "list": {
      "0": {
        "foodName": "맛있는 감자",
        "stock": 3,
      },
      "1": {
        "foodName": "양파",
        "stock": 5,
      },
      "2": {
        "foodName": "김혜자의 감자탕",
        "stock": 1,
      },
      "3": {
        "foodName": "비프 라자냐",
        "stock": 2,
      },
    },
    "recommend": {
      "0": {
        "0": 3,
        "1": 14,
        "2": 1,
      },
      "2": {
        "0": 2,
        "1": 60,
        "2": 0,
      },
    },
   */

  @override
  void initState() {
    super.initState();
    sendImageAndGetOCRResult();
    initRecommendList();
    initFoods();
    initController();
  }

  // 이미지를 보내고, OCR 결과 및 소비기한 추천 데이터를 받음
  void sendImageAndGetOCRResult() async {
    // init dio
    Dio dio = Dio();
    dio.options
      ..baseUrl = baseURI
      ..connectTimeout = const Duration(seconds: 5)
      ..receiveTimeout = const Duration(seconds: 10)
      ..contentType = 'multipart/form-data'; // wrap form-data

    // setup data
    final FormData formData = FormData.fromMap({
      'type': widget.imageType,
      'image': MultipartFile.fromFileSync(widget.imagePath),
    });

    try {
      // send data
      final res = await dio.post(
        '/food/recommend',
        data: formData,
      );

      debugPrint("Status: ${res.statusCode}");
      debugPrint("Data: ${res.data}");

      // handle response
      switch (res.data['status']) {
        case 200:
          setState(() {
            ocrResult = res.data['data'];
            _isLoading = false;
          });
          break;
        case 400:
          throw Exception(res.data['message']);
        default:
          throw Exception('Failed to send data [${res.statusCode}]');
      }
    }
    // when error occured, navigate to home & show error dialog
    catch (err) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const AppPagesContainer(),
        ),
        (route) => false,
      );
      Popups.popSimpleDialog(
        context,
        title: '에러',
        body: '$err',
      );
    } finally {
      dio.close();
    }
  }

  void initRecommendList() {
    // 만약 recommend 데이터가 없으면 어떻게 되는지 여쭤보기
    Map<String, Map<String, dynamic>> rawRecommend = ocrResult['recommend']!;
    rawRecommend.forEach(
      (index, rawRecommendDays) {
        int i = int.parse(index);

        List<DateTime> recommendDays = List.empty(growable: true);
        for (var day in rawRecommendDays.values.toList().cast<int>()) {
          var expireDate = DateTime.now();
          expireDate = DateTime(
            expireDate.year,
            expireDate.month,
            expireDate.day + day,
          );
          recommendDays.add(expireDate);
        }
        setState(() {
          recommendList[i] = recommendDays;
        });
      },
    );

    debugPrint('$recommendList');
  }

  void initFoods() {
    ocrResult['list']!.forEach(
      (key, foodItem) {
        int index = int.parse(key);
        foods.add(
          Food(
            foodName: foodItem['foodName'],
            stock: foodItem['stock'],
            storageWay: '냉장',
            expireDate: recommendList[index] != null
                ? DateFormat('yyyy-MM-dd').parse('${recommendList[index]![0]}')
                : DateFormat('yyyy-MM-dd').parse('${DateTime.now()}'),
          ),
        );
      },
    );
  }

  void initController() {
    for (int index = 0; index < foods.length; index++) {
      _foodNameController.add(TextEditingController());
      _foodNameController[index].text = foods[index].foodName;
    }
  }

  @override
  void dispose() {
    disposeController();
    super.dispose();
  }

  void disposeController() {
    for (var controller in _foodNameController) {
      controller.dispose();
    }
  }

  void setFoodName(int index, String value) {
    setState(() => foods[index].foodName = value);
  }

  void updateFoodNameControllerText(index) {
    setState(() => _foodNameController[index].text = foods[index].foodName);
  }

  void setStorage(int index, String value) {
    setState(() => foods[index].storageWay = value);
  }

  void setStock(int index, num value) {
    setState(() => foods[index].stock = value);
  }

  void setExpireDate(DateTime value, {int? index}) {
    DateTime formattedValue = DateFormat('yyyy-MM-dd').parse('$value');
    setState(() => foods[index!].expireDate = formattedValue);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const LoadingPage();
    } else {
      return AddFoodLayout(
        title: '식품 등록',
        onPressedAddButton: saveFoodInfo,
        containerColor: ColorStyles.snow,
        body: SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            // 식료품 리스트 아이템
            return Card(
              elevation: 3,
              shadowColor: ColorStyles.white,
              margin: const EdgeInsets.only(bottom: 15),
              color: ColorStyles.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
              // 식료품 아이템 좌측 노란색 세로선
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      ColorStyles.mustardYellow,
                      ColorStyles.transparent,
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment(-0.95, 0),
                    stops: [1, 1],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                  ),
                ),
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 30,
                  right: 20,
                  bottom: 10,
                ),
                // 식료품 정보
                child: Column(
                  children: [
                    Row(
                      children: [
                        // 식료품 이름
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: TextField(
                            controller: _foodNameController[index],
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              counterText: '',
                            ),
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLength: 20,
                            onChanged: (value) => setFoodName(index, value),
                            onSubmitted: (value) => updateFoodNameControllerText(index),
                            onTapOutside: (event) {
                              updateFoodNameControllerText(index);
                              FocusScope.of(context).unfocus(); // 키보드 숨김
                            },
                          ),
                        ),
                        const Spacer(),
                        // 아이템 삭제 버튼
                        IconButton(
                          onPressed: () {
                            setState(() {
                              foods.removeAt(index);
                              _foodNameController.removeAt(index);
                            });
                          },
                          icon: const Icon(Icons.close),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                    // 식료품 보관 장소
                    CustomFoodStorageDropdown(
                      index: index,
                      storage: foods[index].storageWay,
                      setStorage: setStorage,
                      recommendList: recommendList.containsKey(index) ? recommendList[index] : null,
                      setExpireDate: setExpireDate,
                    ),
                    // 식료품 수량
                    FoodStockButton(
                      index: index,
                      stock: foods[index].stock,
                      setStock: setStock,
                    ),
                    // 식료품 소비 기한 (+ TIP UI)
                    FoodExpireDate(
                      index: index,
                      expireDate: foods[index].expireDate,
                      setExpireDate: setExpireDate,
                      isRecommended: recommendList.containsKey(index) ? true : false,
                    ),
                  ],
                ),
              ),
            );
          }, childCount: foods.length),
        ),
      );
    }
  }

  // 입력한 식료품 정보를 DB에 저장하는 함수
  void saveFoodInfo() async {
    for (var food in foods) {
      if (food.isFoodValid() == false) {
        Popups.popSimpleDialog(
          context,
          title: '입력 오류',
          body: '입력이 올바르지 않습니다.',
        );
        return;
      }
    }

    // init dio
    Dio dio = Dio();
    dio.options
      ..baseUrl = baseURI
      ..connectTimeout = const Duration(seconds: 5)
      ..receiveTimeout = const Duration(seconds: 10);

    // setup data
    List<Map<String, String>> foodlist = List.empty(growable: true);
    for (var food in foods) {
      foodlist.add(food.toJson());
    }

    Map<String, dynamic> data = {
      "userId": "1",
      "foodList": foodlist,
    };
    debugPrint('$data');

    try {
      // save data
      final res = await dio.post(
        '/food/addList',
        data: data,
      );

      debugPrint("Status: ${res.statusCode}");
      debugPrint("Data: ${res.data}");

      // handle response
      if (!mounted) return;
      switch (res.data['status']) {
        case 200:
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const AppPagesContainer(),
            ),
            (route) => false,
          );
          break;
        case 400:
          throw Exception(res.data['message']);
        default:
          throw Exception('Failed to send data [${res.statusCode}]');
      }
    }
    // when error occured, show error dialog
    catch (err) {
      Popups.popSimpleDialog(
        context,
        title: '에러',
        body: '$err',
      );
    } finally {
      dio.close();
    }
  }
}

// 기존 FoodStoragDropdown에 소비기한 추천 기능을 적용함
class CustomFoodStorageDropdown extends StatelessWidget {
  final String storage;
  final int index;
  final void Function(int index, String value) setStorage;
  // 소비기한 추천 기능을 위한 필드
  final List<DateTime>? recommendList;
  final void Function(DateTime value, {int? index}) setExpireDate;

  CustomFoodStorageDropdown({
    super.key,
    required this.index,
    required this.storage,
    required this.setStorage,
    required this.recommendList,
    required this.setExpireDate,
  });

  final storages = ['냉장', '냉동', '실온'];

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('보관방법'),
        const Spacer(),
        DropdownButton(
          value: storage,
          items: storages
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(
                      e,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ))
              .toList(),
          onChanged: (value) {
            setStorage(index, value!);
            if (recommendList != null) {
              setRecommendedExpireDate(value);
            }
          },
          icon: const Icon(Icons.arrow_drop_down_rounded),
          iconSize: 20,
          underline: Container(),
          elevation: 2,
          dropdownColor: ColorStyles.white,
        ),
      ],
    );
  }

  void setRecommendedExpireDate(String value) {
    for (var i = 0; i < storages.length; i++) {
      if (value == storages[i]) {
        setExpireDate(recommendList![i], index: index);
        break;
      }
    }
  }
}
