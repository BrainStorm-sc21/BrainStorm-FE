import 'package:brainstorm_meokjang/utilities/Colors.dart';
import 'package:flutter/material.dart';

class PhoneLoginPage extends StatelessWidget {
  const PhoneLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("번호인증 로그인"),
        backgroundColor: ColorStyles.mainColor,
      ),
      body: Column(
        children: [
          Text(
            "서비스 이용을 위해 \n번호를 입력해주세요.",
          ),
          TextField()
        ],
      ),
    );
  }
}
