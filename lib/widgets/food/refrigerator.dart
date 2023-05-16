import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:brainstorm_meokjang/models/food.dart';
import 'package:brainstorm_meokjang/widgets/all.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class Refrigerator extends StatefulWidget {
  final String storage;
  const Refrigerator({super.key, required this.storage});

  @override
  State<Refrigerator> createState() => _RefrigeratorState();
}

class _RefrigeratorState extends State<Refrigerator> {
  late Food food;
  List<Food> foodList = List.empty(growable: true);

  List<Food> exampleFood = [
    Food(
        foodId: 0,
        foodName: "토마토",
        storageWay: "냉장",
        stock: 2,
        expireDate: DateFormat('yyyy-MM-dd').parse('${DateTime.now()}')),
    Food(
        foodId: 1,
        foodName: "감자",
        storageWay: "실온",
        stock: 5,
        expireDate: DateFormat('yyyy-MM-dd').parse('${DateTime.now()}')),
    Food(
        foodId: 2,
        foodName: "가지",
        storageWay: "냉동",
        stock: 1,
        expireDate: DateFormat('yyyy-MM-dd').parse('${DateTime.now()}')),
    Food(
        foodId: 3,
        foodName: "버섯",
        storageWay: "냉장",
        stock: 4,
        expireDate: DateFormat('yyyy-MM-dd').parse('${DateTime.now()}'))
  ];
  List<bool> absorbBool = List.filled(100, true, growable: true);

  final List<TextEditingController> _foodNameController = [];

  @override
  void initState() {
    super.initState();

    food = Food(
      foodId: 1,
      foodName: '',
      storageWay: '냉장',
      stock: 1,
      expireDate: DateFormat('yyyy-MM-dd').parse('${DateTime.now()}'),
    );

    initFoods();
    initController();
  }

  void setStock(int index, num value) => setState(() => foodList[index].stock = value);
  void setStorage(int index, String value) => setState(() => foodList[index].storageWay = value);
  void setExpireDate(DateTime value, {int? index}) =>
      setState(() => foodList[index!].expireDate = value);

  void initFoods() {
    for (var fooditem in exampleFood) {
      if (widget.storage == "전체" || widget.storage == fooditem.storageWay) {
        foodList.add(Food(
          foodId: fooditem.foodId,
          foodName: fooditem.foodName,
          stock: fooditem.stock,
          storageWay: fooditem.storageWay,
          expireDate: fooditem.expireDate,
        ));
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
  void dispose() {
    disposeController();
    super.dispose();
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
          key: PageStorageKey(food.foodId),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
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
                              border: InputBorder.none,
                              counterText: '',
                            ),
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLength: 20,
                          ))),
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
                      index: index, storage: food.storageWay, setStorage: setStorage),
                ),
              ),
              AbsorbPointer(
                absorbing: absorbBool[index],
                child: SizedBox(
                  width: 350,
                  child: FoodStockButton(index: index, stock: food.stock, setStock: setStock),
                ),
              ),
              AbsorbPointer(
                absorbing: absorbBool[index],
                child: SizedBox(
                  width: 350,
                  child: FoodExpireDate(
                      index: index, expireDate: food.expireDate, setExpireDate: setExpireDate),
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
                          ? const Text('수정', style: TextStyle(color: ColorStyles.mainColor))
                          : const Text('확인', style: TextStyle(color: ColorStyles.mainColor)),
                    ),
                    const SizedBox(width: 10),
                    OutlinedButton(
                      child: const Text('삭제', style: TextStyle(color: ColorStyles.mainColor)),
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
