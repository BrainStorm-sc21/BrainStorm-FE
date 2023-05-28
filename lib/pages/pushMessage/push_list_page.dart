import 'package:brainstorm_meokjang/utilities/Colors.dart';
import 'package:flutter/material.dart';

class PushList extends StatelessWidget{
  const PushList({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("알림"),centerTitle: true, backgroundColor: ColorStyles.mainColor,),
      body: const Center(child:Text("아무 알림이 없습니다")),
    );
  }

}