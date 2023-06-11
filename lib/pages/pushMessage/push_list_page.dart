import 'package:brainstorm_meokjang/utilities/Colors.dart';
import 'package:flutter/material.dart';

class PushList extends StatelessWidget {
  const PushList({super.key});

  TabBar get _tabBar => const TabBar(
          padding: EdgeInsets.only(top: 10),
          isScrollable: false,
          indicatorColor: ColorStyles.mainColor,
          indicatorWeight: 4,
          labelColor: ColorStyles.mainColor,
          unselectedLabelColor: ColorStyles.textColor,
          labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          tabs: [
            Tab(text: "소비 기한"),
            Tab(text: "채팅"),
            Tab(
              text: "리뷰",
            )
          ]);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: const Text("알림"),
            centerTitle: true,
            backgroundColor: ColorStyles.mainColor,
          ),
          body: Column(
            children: [
              _tabBar,
              const Divider(
                  height: 0,
                  color: ColorStyles.lightgrey,
                  thickness: 1.5,
                  endIndent: 10),
            ],
          )
          //const Center(child: Text("아무 알림이 없습니다")),
          ),
    );
  }
}
