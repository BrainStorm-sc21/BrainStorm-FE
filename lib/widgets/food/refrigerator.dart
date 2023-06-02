import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:brainstorm_meokjang/models/food.dart';
import 'package:brainstorm_meokjang/utilities/domain.dart';
import 'package:brainstorm_meokjang/utilities/popups.dart';
import 'package:brainstorm_meokjang/utilities/toast.dart';
import 'package:brainstorm_meokjang/widgets/all.dart';
import 'package:brainstorm_meokjang/widgets/customProgressBar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Refrigerator extends StatefulWidget {
  final int userId;
  final String storage;
  final List<Food> foodList;
  const Refrigerator(
      {super.key,
      required this.userId,
      required this.foodList,
      required this.storage});

  @override
  State<Refrigerator> createState() => _RefrigeratorState();
}

class _RefrigeratorState extends State<Refrigerator> {
  late Food food;
  List<Food> foodList = List.empty(growable: true);
  List<bool> absorbBool = List.filled(100, true, growable: true);
  final now = DateTime.now();

  final List<TextEditingController> _foodNameController = [];

  void deleteServerDataWithDio(index) async {
    Dio dio = Dio();
    dio.options
      ..baseUrl = baseURI
      ..connectTimeout = const Duration(seconds: 5)
      ..receiveTimeout = const Duration(seconds: 10);

    var deleteFood = foodList[index].foodId;

    try {
      final resp = await dio.delete("/food/$deleteFood");

      showToast('식료품이 삭제되었습니다');

      print("Delete Status: ${resp.statusCode}");
    } catch (e) {
      Exception(e);
    } finally {
      dio.close();
    }
  }

  void modifyFoodInfo(index) async {
    Dio dio = Dio();
    dio.options
      ..baseUrl = baseURI
      ..connectTimeout = const Duration(seconds: 5)
      ..receiveTimeout = const Duration(seconds: 10);

    final data = {
      "userId": widget.userId,
      "food": foodList[index].toJson(),
    };

    var modifyFoodId = foodList[index].foodId;

    try {
      final res = await dio.put('/food/$modifyFoodId', data: data);

      if (!mounted) return;
      if (res.statusCode == 200) {
        Popups.popSimpleDialog(
          context,
          title: foodList[index].foodName,
          body: '값이 수정되었습니다',
        );
      } else {
        throw Exception('Failed to send data [${res.statusCode}]');
      }
    }
    // when error occured, show error dialog
    on DioError catch (err) {
      Popups.popSimpleDialog(
        context,
        title: '${err.type}',
        body: '${err.message}',
      );
    } catch (err) {
      debugPrint('$err');
    } finally {
      dio.close();
    }
  }

  void initFoods() {
    for (Food fooditem in widget.foodList) {
      if (widget.storage == "전체" || widget.storage == fooditem.storageWay) {
        foodList.add(fooditem);
      }
    }
  }

  void initController() {
    for (int index = 0; index < foodList.length; index++) {
      _foodNameController.add(TextEditingController());
      _foodNameController[index].text = foodList[index].foodName;
    }
  }

  @override
  void initState() {
    super.initState();
    initFoods();
    initController();
  }

  void setStock(int index, num value) =>
      setState(() => foodList[index].stock = value);
  void setStorage(int index, String value) =>
      setState(() => foodList[index].storageWay = value);
  void setExpireDate(DateTime value, {int? index}) =>
      setState(() => foodList[index!].expireDate = value);

  void deleteFood(int index) => setState(() {
        foodList.removeAt(index);
        _foodNameController.removeAt(index);
      });

  int dayCount(day) {
    if (day >= 7) {
      return 7;
    } else if (day <= 0) {
      return 0;
    } else {
      return day;
    }
  }

  @override
  void dispose() {
    super.dispose();
    disposeController();
  }

  void disposeController() {
    for (var controller in _foodNameController) {
      controller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return foodList.isEmpty
        ? Center(child: Text("${widget.storage}에는 음식이 없어요!"))
        : ListView.builder(
            itemCount: foodList.length,
            itemBuilder: (context, index) {
              food = foodList[index];
              return Card(
                elevation: 2.0,
                key: PageStorageKey(_foodNameController[index]),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                surfaceTintColor: ColorStyles.hintTextColor,
                child: ExpansionTile(
                  initiallyExpanded: false,
                  title: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AbsorbPointer(
                              absorbing: absorbBool[index],
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: TextField(
                                    controller: _foodNameController[index],
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        counterText: ''),
                                    style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600,
                                        overflow: TextOverflow.ellipsis),
                                    maxLength: 20),
                              ),
                            ),
                            Text('${food.expireDate.difference(now).inDays}일',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w400,
                                    color:
                                        food.expireDate.difference(now).inDays >
                                                0
                                            ? ColorStyles.textColor
                                            : ColorStyles.errorRed))
                          ],
                        ),
                        CustomProgressBar(
                            maxPercent: 7,
                            currentPercent: 7 -
                                dayCount(
                                    food.expireDate.difference(now).inDays))
                      ],
                    ),
                  ),
                  children: [
                    AbsorbPointer(
                        absorbing: absorbBool[index],
                        child: SizedBox(
                            width: 350,
                            child: FoodStorageDropdown(
                                index: index,
                                storage: food.storageWay,
                                setStorage: setStorage))),
                    AbsorbPointer(
                      absorbing: absorbBool[index],
                      child: SizedBox(
                        width: 350,
                        child: FoodStockButton(
                            index: index,
                            stock: food.stock,
                            setStock: setStock),
                      ),
                    ),
                    AbsorbPointer(
                      absorbing: absorbBool[index],
                      child: SizedBox(
                        width: 350,
                        child: FoodExpireDate(
                            index: index,
                            expireDate: food.expireDate,
                            setExpireDate: setExpireDate),
                      ),
                    ),
                    SizedBox(
                      width: 350,
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              setState(() {
                                absorbBool[index] = !absorbBool[index];
                                if (absorbBool[index]) {
                                  modifyFoodInfo(index);
                                }
                              });
                            },
                            child: absorbBool[index]
                                ? const Text('수정',
                                    style:
                                        TextStyle(color: ColorStyles.mainColor))
                                : const Text('확인',
                                    style: TextStyle(
                                        color: ColorStyles.mainColor)),
                          ),
                          const SizedBox(width: 10),
                          OutlinedButton(
                            child: const Text('삭제',
                                style: TextStyle(color: ColorStyles.mainColor)),
                            onPressed: () {
                              showDeleteDialog(index);
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          );
  }

  // 삭제 확인 다이얼로그
  void showDeleteDialog(index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("정말로 삭제하시겠습니까?"),
          actions: [
            // 취소 버튼
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("취소"),
            ),
            // 확인 버튼
            TextButton(
              onPressed: () {
                deleteServerDataWithDio(index);
                deleteFood(index);
                Navigator.pop(context);
              },
              child: const Text(
                "확인",
                style: TextStyle(color: Colors.pink),
              ),
            ),
          ],
        );
      },
    );
  }
}
