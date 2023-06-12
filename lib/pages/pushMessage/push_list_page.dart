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
              Expanded(
                child: TabBarView(children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Container(
                      child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return const PushUnit(
                              type: '소비기한',
                              time: '1분 전',
                              title: '눈을 감자의 소비기한이 2일 남았습니다!');
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Container(
                      child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return const PushUnit(
                              type: '채팅',
                              time: '3분 전',
                              title: '먹짱2호 님에게 채팅이 왔습니다!!');
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Container(
                      child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return const PushUnit(
                              type: '리뷰',
                              time: '5분 전',
                              title: '먹짱3호님이 리뷰를 남기셨습니다!!!');
                        },
                      ),
                    ),
                  ),
                ]),
              )
            ],
          )
          //const Center(child: Text("아무 알림이 없습니다")),
          ),
    );
  }
}

class PushUnit extends StatelessWidget {
  final String type;
  final String time;
  final String title;
  const PushUnit(
      {super.key, required this.type, required this.time, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          print('푸시알림 클릭!');
        },
        child: Container(
          decoration: BoxDecoration(
            color: ColorStyles.lightGrey,
            borderRadius: BorderRadius.circular(20),
          ),
          width: double.infinity,
          height: 70,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(type,
                        style: const TextStyle(fontWeight: FontWeight.w500)),
                    const SizedBox(width: 10),
                    Text(
                      time,
                      style: const TextStyle(fontSize: 13),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: const TextStyle(
                      color: ColorStyles.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
