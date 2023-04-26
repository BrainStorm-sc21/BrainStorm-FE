import 'package:brainstorm_meokjang/utilities/Colors.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("회원가입"),
        backgroundColor: ColorStyles.mainColor,
      ),
    );
  }
}
