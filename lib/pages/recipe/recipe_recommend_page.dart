import 'package:brainstorm_meokjang/models/food.dart';
import 'package:brainstorm_meokjang/models/recipe.dart';
import 'package:brainstorm_meokjang/providers/foodList_controller.dart';
import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:brainstorm_meokjang/widgets/rounded_outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecipeRecommendPage extends StatelessWidget {
  const RecipeRecommendPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FoodListController foodListController =
        Get.find<FoodListController>();
    List<Food> foodsList = foodListController.foodList;
    Recipe selectedFoods = Recipe(recipeFoods: []);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "레시피 도우미",
          style: TextStyle(color: ColorStyles.black, fontSize: 20),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: ColorStyles.backgroundColor,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context); //뒤로가기
            },
            color: ColorStyles.black,
            icon: const Icon(Icons.arrow_back_ios_new_rounded)),
      ),
      body: Container(
        color: ColorStyles.backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 55,
                    height: 55,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        "assets/images/recipe.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("레시피 도우미"),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: 45,
                        decoration: BoxDecoration(
                          color: ColorStyles.mainColor,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(15),
                            topLeft: Radius.circular(15),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 3,
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: const Text(
                          "찾고 있는 레시피가 있나요?",
                          style: TextStyle(
                              color: ColorStyles.white,
                              height: 2.3,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: 150,
                        decoration: BoxDecoration(
                          color: ColorStyles.white,
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 3,
                              blurRadius: 8,
                            )
                          ],
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "궁금한 레시피가 있다면 재료를 선택 후 하단 버튼을 눌러주세요!",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: ColorStyles.textColor),
                                ),
                                RoundedOutlinedButton(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  height: 25,
                                  backgroundColor: ColorStyles.lightGrey,
                                  borderColor: ColorStyles.lightGrey,
                                  foregroundColor: ColorStyles.textColor,
                                  onPressed: () {
                                    print(selectedFoods.recipeFoods);
                                    foodListController.getRecipe(selectedFoods);
                                  },
                                  text: '레시피 추천 시작',
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            )),
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.45,
              decoration: BoxDecoration(
                color: ColorStyles.white,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(25),
                  topLeft: Radius.circular(25),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 3,
                      blurRadius: 8),
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    child: Container(
                      width: 130,
                      height: 5,
                      decoration: BoxDecoration(
                          color: ColorStyles.lightGrey,
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.35,
                    child: GetBuilder<FoodListController>(// 단순 상태 관리
                        builder: (controller) {
                      return SingleChildScrollView(
                        child: Wrap(
                          spacing: 20,
                          runSpacing: 15,
                          children: List<Widget>.generate(
                            foodsList.length,
                            (i) {
                              return SizedBox(
                                child: RoundedOutlinedButton(
                                  backgroundColor:
                                      foodListController.isSelected[i]
                                          ? ColorStyles.mainColor
                                          : ColorStyles.white,
                                  borderColor: ColorStyles.mainColor,
                                  foregroundColor:
                                      foodListController.isSelected[i]
                                          ? ColorStyles.white
                                          : ColorStyles.mainColor,
                                  onPressed: () {
                                    if (foodListController.isSelected[i] ==
                                        true) {
                                      selectedFoods.recipeFoods
                                          .remove(foodsList[i].foodName);
                                    } else {
                                      selectedFoods.recipeFoods
                                          .add(foodsList[i].foodName);
                                    }
                                    foodListController.changedSelected(i);
                                  },
                                  text: foodsList[i].foodName,
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
