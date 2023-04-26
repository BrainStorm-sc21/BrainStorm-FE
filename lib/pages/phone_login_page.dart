import 'package:brainstorm_meokjang/pages/home_page.dart';
import 'package:brainstorm_meokjang/utilities/Colors.dart';
import 'package:flutter/material.dart';

class PhoneLoginPage extends StatelessWidget {
  const PhoneLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("번호인증 로그인"),
        backgroundColor: ColorStyles.mainColor,
      ),
      body: Center(
        child: Container(
          height: deviceHeight * 0.5,
          width: deviceWidth * 0.8,
          child: Column(
            children: [
              const Text(
                "서비스 이용을 위해 \n번호를 입력해주세요.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: ColorStyles.mainColor),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "휴대폰 번호(-없이 숫자만 입력)",
                  ),
                  keyboardType: TextInputType.phone,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  width: deviceWidth * 0.8,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PhoneAuthPage()),
                      );
                    },
                    child: Text("인증 문자 받기"),
                    style: ElevatedButton.styleFrom(
                        primary: ColorStyles.mainColor),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PhoneAuthPage extends StatelessWidget {
  const PhoneAuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("번호인증 로그인"),
        backgroundColor: ColorStyles.mainColor,
      ),
      body: Center(
        child: Container(
          height: deviceHeight * 0.5,
          width: deviceWidth * 0.8,
          child: Column(
            children: [
              const Text(
                "인증번호가 \n문자로 전송되었습니다.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: ColorStyles.mainColor),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "인증번호 입력",
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  width: deviceWidth * 0.8,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
                      );
                    },
                    child: Text("인증하고 로그인하기"),
                    style: ElevatedButton.styleFrom(
                        primary: ColorStyles.mainColor),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
