import 'package:flutter/material.dart';

class Popups {
  static void unsigned(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Text("가입되지 않은 사용자 정보입니다.\n회원가입을 진행해 주세요."),
        );
      },
    );
  }

  static void alreadySigned(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Text("이미 가입되어 있습니다!"),
        );
      },
    );
  }
}
