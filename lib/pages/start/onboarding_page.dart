import 'package:brainstorm_meokjang/pages/start/start_page.dart';
import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 200),
        child: IntroductionScreen(
          globalFooter: SizedBox(
            width: double.infinity,
            height: 120,
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const StartPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorStyles.mainColor,
                    ),
                    child: const Text(
                      '먹장! 시작하기',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          pages: [
            PageViewModel(
              title: "언제, 어디서든\n냉장고 속 식품 확인",
              body: "",
              image: Center(
                child: Image.asset(
                  'assets/images/온보딩화면1.png',
                ),
              ),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: "주변 이웃들과\n거래하며 식비절약",
              body: "",
              image: Center(
                child: Image.asset(
                  'assets/images/온보딩화면2.png',
                ),
              ),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: "나에게 꼭 맞는 레시피 추천",
              body: "",
              image: Center(
                child: Image.asset(
                  'assets/images/온보딩화면3.png',
                ),
              ),
              decoration: getPageDecoration(),
            ),
          ],
          showNextButton: false,
          showDoneButton: false,
          onDone: () {},
        ),
      ),
    );
  }
}

PageDecoration getPageDecoration() {
  return const PageDecoration(
    bodyPadding: EdgeInsets.fromLTRB(16, 0, 16, 16),
    imagePadding: EdgeInsets.zero,
  );
}
