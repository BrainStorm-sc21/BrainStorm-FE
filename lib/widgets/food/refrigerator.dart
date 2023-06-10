import 'package:brainstorm_meokjang/providers/foodList_controller.dart';
import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:brainstorm_meokjang/models/food.dart';
import 'package:brainstorm_meokjang/utilities/toast.dart';
import 'package:brainstorm_meokjang/widgets/customProgressBar.dart';
import 'package:brainstorm_meokjang/widgets/food/modify_bottomSheet.dart';
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
  late Food modifyFood;
  final now = DateTime.now();

  final FoodListController _foodListController = Get.find<FoodListController>();

  String stockString(num value) {
    if (value >= 2 || value == 1) {
      return "${value.ceil()} 개";
    } else {
      return "$value 개";
    }
  }

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
                child: ExpansionTile(
                  initiallyExpanded: false,
                  title: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Text(food.foodName,
                                    style: const TextStyle(
                                        color: ColorStyles.textColor,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600,
                                        overflow: TextOverflow.ellipsis)),
                              ),
                              Text(
                                  '${food.expireDate.difference(now).inDays + 1}일',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w400,
                                      color: food.expireDate
                                                  .difference(now)
                                                  .inDays >
                                              -1
                                          ? ColorStyles.textColor
                                          : ColorStyles.errorRed))
                            ],
                          ),
                        ),
                        CustomProgressBar(
                            maxPercent: 7,
                            currentPercent: 7 -
                                dayCount(
                                        food.expireDate.difference(now).inDays +
                                            1)
                                    .toDouble())
                      ],
                    ),
                  ),
                  children: [
                    detailList(context, "보관방법", food.storageWay),
                    detailList(context, "수량", stockString(food.stock)),
                    detailList(context, "소비기한",
                        food.expireDate.toString().substring(0, 10)),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: 350,
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              modifyFood = Food(
                                  foodId: widget.foods[index].foodId,
                                  foodName: widget.foods[index].foodName,
                                  storageWay: widget.foods[index].storageWay,
                                  stock: widget.foods[index].stock,
                                  expireDate: widget.foods[index].expireDate);
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return ModifyFoodBottomSheet(
                                      modifyFood: modifyFood,
                                      userId: widget.userId);
                                },
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                              );
                            },
                            child: const Text('수정',
                                style: TextStyle(color: ColorStyles.mainColor)),
                          ),
                          const SizedBox(width: 10),
                          OutlinedButton(
                            child: const Text('삭제',
                                style: TextStyle(color: ColorStyles.mainColor)),
                            onPressed: () {
                              showDeleteDialog(widget.foods[index]);
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

  Widget detailList(BuildContext context, String name, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        width: 350,
        child: Row(
          children: [
            Text(name),
            const Spacer(),
            Text(value,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
          ],
        ),
      ),
    );
  }
}
