import 'package:brainstorm_meokjang/utilities/Colors.dart';
import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("먹장!"),
        backgroundColor: ColorStyles.mainColor,
      ),
      body: Center(
        child: Center(
          child: Column(
            children: [
              Container(
                width: deviceWidth * 0.8,
                child: ElevatedButton(
                  child: Text("카카오톡으로 로그인"),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: Colors.yellow,
                  ),
                ),
              ),
              Container(
                width: deviceWidth * 0.8,
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
                width: deviceWidth * 0.8,
                child: ElevatedButton(
                  child: Text("번호인증으로 로그인"),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: ColorStyles.mainColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 120),
                child: TextButton(
                  child: Text("회원가입"),
                  onPressed: () {},
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
