import 'package:brainstorm_meokjang/utilities/colors.dart';
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
      child: Stack(
        fit: StackFit.loose,
        children: [
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.3,
            left: MediaQuery.of(context).size.width * 0.25,
            child: Image.asset(
              'assets/images/smart_add_loading.png',
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.contain,
            ),
          ),
          const Align(
            alignment: AlignmentDirectional(0, 0.55),
            child: Text(
              '스캔한 식품들을\n냉장고에 넣고 있어요',
              textAlign: TextAlign.center,
              style: TextStyle(
                  decoration: TextDecoration.none,
                  color: ColorStyles.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.normal,
                  letterSpacing: -1),
            ),
          ),
        ],
      ),
    );
  }
}
