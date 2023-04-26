import 'package:brainstorm_meokjang/utilities/Colors.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:intro_screen_onboarding_flutter/intro_app.dart';

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
            height: 150,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ElevatedButton(
                    child: const Text(
                      '로그인',
                    ),
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      primary: ColorStyles.mainColor,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextButton(
                    child: const Text(
                      '회원가입',
                    ),
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      primary: ColorStyles.mainColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          pages: [
            PageViewModel(
              title: "첫번째 온보딩 페이지",
              body: "실시간 우리동네 인기식품",
              image: Center(
                child: Image.asset(
                  'assets/images/임시온보딩화면1.png',
                ),
              ),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: "두번째 온보딩 페이지",
              body: "오늘의 추천 레시피",
              image: Center(
                child: Image.asset(
                  'assets/images/임시온보딩화면1.png',
                ),
              ),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: "세번째 온보딩 페이지",
              body: "우리동네 공동구매 현황",
              image: Center(
                child: Image.asset(
                  'assets/images/임시온보딩화면1.png',
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
    pageColor: Colors.white,
  );
}
