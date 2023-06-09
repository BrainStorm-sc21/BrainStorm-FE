import 'package:brainstorm_meokjang/providers/foodList_controller.dart';
import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:brainstorm_meokjang/models/food.dart';
import 'package:brainstorm_meokjang/utilities/toast.dart';
import 'package:brainstorm_meokjang/widgets/all.dart';
import 'package:brainstorm_meokjang/widgets/customProgressBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Refrigerator extends StatefulWidget {
  final int userId;
  final String storage;
  final List<Food> foods;
  const Refrigerator(
      {super.key,
      required this.userId,
      required this.foods,
      required this.storage});

  @override
  State<Refrigerator> createState() => _RefrigeratorState();
}

class _RefrigeratorState extends State<Refrigerator> {
  late Food food;
  List<bool> absorbBool = List.filled(100, true, growable: true);
  final now = DateTime.now();

  final FoodListController _foodListController = Get.find<FoodListController>();

  @override
  void initState() {
    super.initState();
  }

  void setStock(int index, num value) =>
      setState(() => widget.foods[index].stock = value);
  void setStorage(int index, String value) =>
      setState(() => widget.foods[index].storageWay = value);
  void setExpireDate(DateTime value, {int? index}) =>
      setState(() => widget.foods[index!].expireDate = value);

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
  Widget build(BuildContext context) {
    return widget.foods.isEmpty
        ? Center(child: Text("${widget.storage}에는 음식이 없어요!"))
        : ListView.builder(
            itemCount: widget.foods.length,
            itemBuilder: (context, index) {
              food = widget.foods[index];
              return Card(
                elevation: 2.0,
                key: PageStorageKey(food.foodId),
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
                                    enabled: !absorbBool[index],
                                    controller: food.foodNameController,
                                    onSubmitted: (String str) {
                                      setState(() {
                                        food.foodName = str;
                                      });
                                    },
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
                                dayCount(food.expireDate.difference(now).inDays)
                                    .toDouble())
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
                                  _foodListController.modifyFoodInfo(
                                      widget.userId, widget.foods[index]);
                                  showToast('식료품이 수정되었습니다');
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
                            child: absorbBool[index]
                                ? const Text('삭제',
                                    style:
                                        TextStyle(color: ColorStyles.mainColor))
                                : const Text('취소',
                                    style: TextStyle(
                                        color: ColorStyles.mainColor)),
                            onPressed: () {
                              if (absorbBool[index]) {
                                showDeleteDialog(widget.foods[index]);
                              } else {
                                setState(() {
                                  absorbBool[index] = !absorbBool[index];
                                });
                              }
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
  void showDeleteDialog(food) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text("정말로 삭제하시겠습니까?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("취소"),
            ),
            TextButton(
              onPressed: () {
                _foodListController.deleteServerDataWithDio(food);
                showToast('식료품이 삭제되었습니다');
                Navigator.pop(context);
              },
              child: const Text("확인", style: TextStyle(color: Colors.pink)),
            ),
          ],
        );
      },
    );
  }
}
