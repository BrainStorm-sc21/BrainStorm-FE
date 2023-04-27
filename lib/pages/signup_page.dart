import 'package:brainstorm_meokjang/utilities/Colors.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("회원가입"),
        backgroundColor: ColorStyles.mainColor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Container(
          child: ListView(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  NicknameField(),
                  GenderField(),
                  PositionField(),
                  AuthField(),
                  Container(
                    width: deviceWidth * 0.8,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "회원가입하기",
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: ColorStyles.mainColor,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NicknameField extends StatelessWidget {
  const NicknameField({super.key});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Container(
        child: Column(
          children: [
            Container(
              width: deviceWidth * 0.8,
              child: Text(
                "닉네임",
                textAlign: TextAlign.start,
              ),
            ),
            TextField(),
          ],
        ),
      ),
    );
  }
}

class GenderField extends StatelessWidget {
  const GenderField({super.key});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Container(
        child: Column(
          children: [
            Container(
              width: deviceWidth * 0.8,
              child: Text(
                "성별",
                textAlign: TextAlign.start,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: deviceWidth * 0.4,
                  child: TextButton(
                    onPressed: () {},
                    child: Text("남"),
                    style: TextButton.styleFrom(
                      primary: Colors.blue,
                    ),
                  ),
                ),
                Container(
                  width: deviceWidth * 0.4,
                  child: TextButton(
                    onPressed: () {},
                    child: Text("여"),
                    style: TextButton.styleFrom(
                      primary: Colors.red,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class PositionField extends StatelessWidget {
  const PositionField({super.key});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Container(
        child: Column(
          children: [
            Container(
              width: deviceWidth * 0.8,
              child: Text(
                "주소",
                textAlign: TextAlign.start,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: deviceWidth * 0.65,
                  child: TextField(),
                ),
                Container(
                  width: deviceWidth * 0.15,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "검색",
                      style: TextStyle(fontSize: 12),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class AuthField extends StatelessWidget {
  const AuthField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {},
              child: Text("카카오톡 인증"),
              style: TextButton.styleFrom(
                primary: ColorStyles.mainColor,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text("구글 인증"),
              style: TextButton.styleFrom(
                primary: ColorStyles.mainColor,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text("번호 인증"),
              style: TextButton.styleFrom(
                primary: ColorStyles.mainColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
