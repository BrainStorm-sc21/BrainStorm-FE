import 'package:brainstorm_meokjang/main.dart';
import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:brainstorm_meokjang/models/food.dart';
import 'package:brainstorm_meokjang/utilities/domain.dart';
import 'package:brainstorm_meokjang/widgets/all.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class Refrigerator extends StatefulWidget {
  final String storage;
  final List<Food> foodList;
  const Refrigerator(
      {super.key, required this.foodList, required this.storage});

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

    var foodId = foodList[index].foodId;

    try {
      final resp = await dio.delete("/food/$foodId");

      print("Delete Status: ${resp.statusCode}");

      // handle response
      if (!mounted) return;
      if (resp.statusCode == 200) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const MyHomePage(),
          ),
          (route) => false,
        );
      } else {
        throw Exception('Failed to send data [${resp.statusCode}]');
      }
    } catch (e) {
      Exception(e);
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
    setState(() {
      initFoods();
      initController();
    });
  }

  void setStock(int index, num value) =>
      setState(() => foodList[index].stock = value);
  void setStorage(int index, String value) =>
      setState(() => foodList[index].storageWay = value);
  void setExpireDate(DateTime value, {int? index}) =>
      setState(() => foodList[index!].expireDate = value);

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
    return ListView.builder(
      itemCount: foodList.length,
      itemBuilder: (context, index) {
        food = foodList[index];
        return Card(
          //key: PageStorageKey(food.foodId),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: ExpansionTile(
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
                                  border: InputBorder.none, counterText: ''),
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
                              color: food.expireDate.difference(now).inDays > 0
                                  ? ColorStyles.textColor
                                  : ColorStyles.errorRed))
                    ],
                  ),
                  progressBars(context, food.expireDate.difference(now).inDays)
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
                      index: index, stock: food.stock, setStock: setStock),
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
                        });
                      },
                      child: absorbBool[index]
                          ? const Text('수정',
                              style: TextStyle(color: ColorStyles.mainColor))
                          : const Text('확인',
                              style: TextStyle(color: ColorStyles.mainColor)),
                    ),
                    const SizedBox(width: 10),
                    OutlinedButton(
                      child: const Text('삭제',
                          style: TextStyle(color: ColorStyles.mainColor)),
                      onPressed: () {
                        print(foodList[index].foodName);
                        print(foodList[index].foodId);
                        print(index);
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
                //Navigator.pop(context);
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

Widget progressBars(BuildContext context, day) {
  int dayCount() {
    if (day >= 7) {
      return 7;
    } else if (day <= 0) {
      return 0;
    } else {
      return day;
    }
  }

  return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: StepProgressIndicator(
        totalSteps: 7,
        currentStep: 7 - dayCount(),
        size: 10,
        padding: 0,
        roundedEdges: const Radius.circular(10),
        selectedGradientColor: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [ColorStyles.expireRedColor, ColorStyles.expireOrangeColor],
        ),
        unselectedGradientColor: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [ColorStyles.hintTextColor, ColorStyles.hintTextColor],
        ),
      ));
}
