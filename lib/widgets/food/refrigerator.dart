import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:brainstorm_meokjang/models/food.dart';
import 'package:brainstorm_meokjang/widgets/all.dart';
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

  final List<TextEditingController> _foodNameController = [];

  void initFoods() {
    for (Food fooditem in widget.foodList) {
      if (widget.storage == "전체" || widget.storage == fooditem.storageWay) {
        foodList.add(fooditem);
      }
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

  void initController() {
    for (int index = 0; index < foodList.length; index++) {
      _foodNameController.add(TextEditingController());
      _foodNameController[index].text = foodList[index].foodName;
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
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AbsorbPointer(
                      absorbing: absorbBool[index],
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: TextField(
                              controller: _foodNameController[index],
                              decoration: const InputDecoration(
                                  border: InputBorder.none, counterText: ''),
                              style: const TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.w600),
                              maxLength: 20))),
                  progressBars(context),
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
  void showDeleteDialog(int index) {
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
                setState(() {
                  foodList.removeAt(index);
                  print('$index 삭제!');
                });
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

Widget progressBars(BuildContext context) {
  return const Padding(
    padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
    child: (StepProgressIndicator(
      totalSteps: 7,
      currentStep: 5,
      size: 8,
      padding: 0,
      selectedColor: Colors.yellow,
      unselectedColor: Colors.cyan,
      roundedEdges: Radius.circular(10),
      selectedGradientColor: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.redAccent, Colors.yellowAccent],
      ),
      unselectedGradientColor: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.blueGrey, Colors.grey],
      ),
    )),
  );
}
