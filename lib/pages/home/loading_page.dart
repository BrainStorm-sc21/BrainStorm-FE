import 'package:brainstorm_meokjang/utilities/Colors.dart';
import 'package:flutter/material.dart';

// task 4.07
class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: ColorStyles.mainColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 이 부분을 추후 이미지로 변경
          SizedBox(
            width: 200,
            height: 200,
            child: Container(
              color: ColorStyles.black,
            ),
          ),
          const SizedBox(height: 20.0), // 여백
          const Text(
            '스캔한 식품들을\n냉장고에 넣고 있어요',
            textAlign: TextAlign.center,
            style: TextStyle(
              decoration: TextDecoration.none,
              color: ColorStyles.white,
              fontSize: 20.0,
              fontWeight: FontWeight.w300,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
