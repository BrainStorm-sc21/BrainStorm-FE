import 'package:brainstorm_meokjang/models/food.dart';
import 'package:brainstorm_meokjang/pages/recipe/recipe_recommend_page.dart';
import 'package:brainstorm_meokjang/providers/foodList_controller.dart';
import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:brainstorm_meokjang/widgets/rounded_outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

class RecipeSnappingSheet extends StatelessWidget {
  const RecipeSnappingSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final FoodListController foodListController = Get.find<FoodListController>();
    List<Food> foodsList = foodListController.foodList;
    List<String> selectedFoods = [];

    return Scaffold(
      body: SnappingSheet(
        grabbingHeight: 55,
        grabbing: RecipeGrapping(context),
        sheetBelow: SnappingSheetContent(
          draggable: true,
          child: Container(
            color: ColorStyles.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
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
                            backgroundColor: foodListController.isSelected[i]
                                ? ColorStyles.mainColor
                                : ColorStyles.white,
                            borderColor: ColorStyles.mainColor,
                            foregroundColor: foodListController.isSelected[i]
                                ? ColorStyles.white
                                : ColorStyles.mainColor,
                            onPressed: () {
                              if (foodListController.isSelected[i] == true) {
                                selectedFoods.remove(foodsList[i].foodName);
                              } else {
                                selectedFoods.add(foodsList[i].foodName);
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
          ),
        ),
        child: RecipeRecommendPage(selectedFoods: selectedFoods),
      ),
    );
  }

  Widget RecipeGrapping(BuildContext context) {
    return Container(
        height: 30,
        decoration: BoxDecoration(
          color: ColorStyles.white,
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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 140),
          child: Container(
            decoration:
                BoxDecoration(color: ColorStyles.grey, borderRadius: BorderRadius.circular(20)),
          ),
        ));
  }
}
