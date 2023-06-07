import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:flutter/material.dart';

class RecipeRecommendPage extends StatelessWidget {
  const RecipeRecommendPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: ColorStyles.white,
        flexibleSpace: SafeArea(
          child: Container(
            height: 60,
            color: ColorStyles.white,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  onPressed: () => Navigator.of(context).pop(),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                ),
                const Text(
                  '레시피 도우미',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: ColorStyles.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        color: ColorStyles.white,
        child: const Column(
          children: [
            // 채팅 기록
            // 하단 바
          ],
        ),
      ),
    );
  }
}
