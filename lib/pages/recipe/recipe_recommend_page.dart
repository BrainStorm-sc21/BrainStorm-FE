import 'package:brainstorm_meokjang/providers/foodList_controller.dart';
import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:brainstorm_meokjang/widgets/rounded_outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecipeRecommendPage extends StatefulWidget {
  const RecipeRecommendPage({super.key, required this.selectedFoods});

  final List<String> selectedFoods;

  @override
  State<RecipeRecommendPage> createState() => _RecipeRecommendPageState();
}

class _RecipeRecommendPageState extends State<RecipeRecommendPage> {
  @override
  Widget build(BuildContext context) {
    final FoodListController foodListController = Get.find<FoodListController>();

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
      body: SingleChildScrollView(
        child: Container(
          color: ColorStyles.backgroundColor,
          child: Padding(
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
                                "냉장고에 있는 재료로 만들 수 있는 요리가 궁금하다면 재료를 선택 후 하단 버튼을 눌러주세요!",
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 13, color: ColorStyles.textColor),
                              ),
                              RoundedOutlinedButton(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height: 25,
                                backgroundColor: ColorStyles.lightGrey,
                                borderColor: ColorStyles.lightGrey,
                                foregroundColor: ColorStyles.textColor,
                                onPressed: () {
                                  if (widget.selectedFoods.isNotEmpty) {
                                    foodListController.getRecipe(widget.selectedFoods);
                                  }
                                },
                                text: '레시피 추천 시작',
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          )),
                    ),
                    Obx(() {
                      if (foodListController.isLoading) {
                        return const Padding(
                            padding: EdgeInsets.fromLTRB(100, 50, 0, 0),
                            child: CircularProgressIndicator());
                      } else if (foodListController.recipe.toString() == '') {
                        return Container();
                      } else {
                        return Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 50),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              decoration: BoxDecoration(
                                color: ColorStyles.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 3,
                                    blurRadius: 8,
                                  )
                                ],
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(foodListController.recipe.toString())),
                            ));
                      }
                    }),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
