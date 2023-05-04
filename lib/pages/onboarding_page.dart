import 'package:brainstorm_meokjang/pages/start_page.dart';
import 'package:brainstorm_meokjang/utilities/Colors.dart';
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
                // Container(
                //   width: MediaQuery.of(context).size.width * 0.8,
                //   child: ElevatedButton(
                //     child: const Text(
                //       '로그인',
                //     ),
                //     onPressed: () {},
                //     style: ElevatedButton.styleFrom(
                //       primary: ColorStyles.mainColor,
                //     ),
                //   ),
                // ),
                // Container(
                //   width: MediaQuery.of(context).size.width * 0.8,
                //   child: TextButton(
                //     child: const Text(
                //       '회원가입',
                //     ),
                //     onPressed: () {},
                //     style: TextButton.styleFrom(
                //       primary: ColorStyles.mainColor,
                //     ),
                //   ),
                // )
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
              title: "1st",
              body: "실시간 우리동네 인기식품",
              image: Center(
                child: Image.asset(
                  'assets/images/임시온보딩화면1.png',
                ),
              ),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: "2nd",
              body: "오늘의 추천 레시피",
              image: Center(
                child: Image.asset(
                  'assets/images/임시온보딩화면1.png',
                ),
              ),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: "3rd",
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
  );
}
