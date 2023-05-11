import 'package:brainstorm_meokjang/models/food.dart';
import 'package:brainstorm_meokjang/pages/home/loading_page.dart';
import 'package:brainstorm_meokjang/utilities/Colors.dart';
import 'package:brainstorm_meokjang/widgets/all.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OCRResultPage extends StatefulWidget {
  final Image image;

  const OCRResultPage({super.key, required this.image});

  @override
  State<OCRResultPage> createState() => _OCRResultPageState();
}

class _OCRResultPageState extends State<OCRResultPage> {
  List<Food> foods = List.empty(growable: true);
  final List<TextEditingController> _foodNameController = [];
  late bool _isLoading;
  Map<String, Map<int, Map<String, dynamic>>> ocrResult = {
    'list': {
      0: {
        'food_name': '오! 감자',
        'stock': 1,
      },
      1: {
        'food_name': '된장찌개양념',
        'stock': 2,
      },
      2: {
        'food_name': '깐양파',
        'stock': 3,
      },
      3: {
        'food_name': '오오오.. 감자',
        'stock': 1,
      },
      4: {
        'food_name': '군만둥',
        'stock': 2,
      },
      5: {
        'food_name': '청경채',
        'stock': 3,
      },
    },
    'recommend': {
      0: {
        '냉장': 7,
        '냉동': 60,
        '실온': 3,
      },
      3: {
        '냉장': 70,
        '냉동': 5,
        '실온': 5,
      },
    },
  };

  @override
  void initState() {
    super.initState();
    initLoading();
    initFoods();
  }

  void initFoods() {
    for (var fooditem in ocrResult['list']!.values) {
      foods.add(Food(
        foodName: fooditem['food_name'],
        stock: fooditem['stock'],
        storageWay: '냉장',
        expireDate: DateFormat('yyyy-MM-dd').parse('${DateTime.now()}'),
      ));
    }
  }

  void initLoading() {
    _isLoading = true;
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void setStorage(int index, String value) {
    setState(() => foods[index].storageWay = value);
  }

  void setStock(int index, num value) {
    setState(() => foods[index].stock = value);
  }

  void setExpireDate(DateTime value, {int? index}) {
    setState(() => foods[index!].expireDate = value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _isLoading
          ? const LoadingPage()
          : AddFoodLayout(
              title: '식품 등록',
              containerColor: ColorStyles.lightGrey,
              body: ListView.builder(
                physics: const ScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: foods.length,
                itemBuilder: (context, index) {
                  _foodNameController.add(TextEditingController());
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: const BoxDecoration(
                      color: ColorStyles.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 200.0,
                              child: TextField(
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                controller: _foodNameController[index],
                              ),
                            ),
                            const Spacer(),
                            // TODO: 삭제 기능 수정 필요
                            IconButton(
                              onPressed: () {
                                foods.remove(foods[index]);
                              },
                              icon: const Icon(Icons.close),
                            ),
                          ],
                        ),
                        FoodStorageDropdown(
                          index: index,
                          storage: foods[index].storageWay,
                          setStorage: setStorage,
                        ),
                        FoodStockButton(
                          index: index,
                          stock: foods[index].stock,
                          setStock: setStock,
                        ),
                        FoodExpireDate(
                          expireDate: foods[index].expireDate,
                          setExpireDate: setExpireDate,
                        ),
                      ],
                    ),
                  );
                },
              ),
              onPressedAddButton: saveFoodInfo,
            ),
    );
  }

  // 입력한 식료품 정보를 DB에 저장하는 함수
  void saveFoodInfo() {
    for (var food in foods) {
      if (food.isFoodValid() == false) return;
    }

    for (var food in foods) {
      debugPrint('${food.toJson()}');
    }

    // 추후 DB에 저장하는 로직 구현 필요
  }
}
