import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: IntroductionScreen(
          pages: [
            PageViewModel(
              title: "1",
              body: "첫번째 온보딩 페이지",
            ),
            PageViewModel(
              title: "2",
              body: "두번째 온보딩 페이지",
            ),
            PageViewModel(
              title: "3",
              body: "세번째 온보딩 페이지",
            ),
          ],
          showNextButton: false,
          next: Text(""),
          done: Text("회원가입"),
          onDone: () {},
        ),
      ),
    );
  }
}
