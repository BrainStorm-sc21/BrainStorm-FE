import 'package:brainstorm_meokjang/pages/home_page.dart';
import 'package:brainstorm_meokjang/pages/phone_login_page.dart';
import 'package:brainstorm_meokjang/pages/signup_page.dart';
import 'package:brainstorm_meokjang/utilities/Colors.dart';
import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("먹장!"),
        backgroundColor: ColorStyles.mainColor,
      ),
      body: Center(
        child: Container(
          height: deviceHeight * 0.45,
          child: Column(
            children: [
              Container(
                width: deviceWidth * 0.85,
                child: ElevatedButton(
                  child: Text(
                    "카카오톡으로 로그인",
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: Colors.yellow,
                  ),
                ),
              ),
              Container(
                width: deviceWidth * 0.85,
                child: ElevatedButton(
                  child: Text(
                    "구글로 로그인",
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                  ),
                ),
              ),
              Container(
                width: deviceWidth * 0.85,
                child: ElevatedButton(
                  child: Text("번호인증으로 로그인"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PhoneLoginPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: ColorStyles.mainColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 70),
                child: TextButton(
                  child: Text("회원가입"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpPage()),
                    );
                  },
                  style: TextButton.styleFrom(
                    primary: ColorStyles.mainColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
