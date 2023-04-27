import 'package:brainstorm_meokjang/utilities/Colors.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
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
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        child: Column(
          children: [
            Text(
              "닉네임",
              textAlign: TextAlign.left,
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
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        child: Column(
          children: [
            Text("성별"),
            Row(
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text("남"),
                  style: TextButton.styleFrom(
                    primary: Colors.blue,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text("여"),
                  style: TextButton.styleFrom(
                    primary: Colors.red,
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
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        child: Column(
          children: [
            Text("주소"),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text("주소"),
                  style: ElevatedButton.styleFrom(
                    primary: ColorStyles.mainColor,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("검색"),
                  style: ElevatedButton.styleFrom(
                    primary: ColorStyles.mainColor,
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
    return Container();
  }
}
