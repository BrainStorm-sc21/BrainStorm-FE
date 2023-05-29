import 'package:brainstorm_meokjang/pages/chat/chat_page.dart';
import 'package:brainstorm_meokjang/pages/deal/deal_page.dart';
import 'package:brainstorm_meokjang/pages/home/home_page.dart';
import 'package:brainstorm_meokjang/pages/profile/myProfile.dart';
import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:flutter/material.dart';

// for switching bottom tab in app page container
class AppPagesNumber {
  static const int home = 0;
  static const int deal = 1;
  static const int chat = 2;
  static const int my = 3;
}

class AppPagesContainer extends StatefulWidget {
  final int? index;
  final int? userId;
  const AppPagesContainer({
    super.key,
    required this.userId,
    this.index = AppPagesNumber.home,
  });

  @override
  State<AppPagesContainer> createState() => _AppPagesContainerState();
}

class _AppPagesContainerState extends State<AppPagesContainer> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    print('유저아이디: ${widget.userId}');
  }

  Future<void> setCurrentIndex(newIndex) async {
    setState(() {
      currentIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorStyles.backgroundColor,
        body: IndexedStack(
          index: currentIndex, // index 순서에 해당하는 child를 맨 위에 보여
          children: [
            HomePage(userId: widget.userId!),
            DealPage(userId: widget.userId!),
            ChatPage(userId: widget.userId!),
            MyProfile(userId: widget.userId!),
          ],
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 7),
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 221, 221, 221),
                spreadRadius: 4,
                blurRadius: 8,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            child: BottomNavigationBar(
              currentIndex: currentIndex, // 현재 보여주는 탭
              onTap: (newIndex) {
                print("selected newIndex : $newIndex");
                setCurrentIndex(newIndex); // 버튼 눌렀을 때 누른 페이지로 이동
              },
              selectedItemColor: ColorStyles.darkmainColor, // 선택된 아이콘 색상
              unselectedItemColor: ColorStyles.iconColor, // 선택되지 않은 아이콘 색상
              type: BottomNavigationBarType.fixed,
              //label 숨기려면 사용하기
              /* showSelectedLabels: false,
        showUnselectedLabels: false, */
              backgroundColor: Colors.white,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: '냉장고'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.groups_2), label: '같이먹장'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.chat_bubble), label: '채팅'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person_2), label: '마이페이지'),
              ],
            ),
          ),
        ));
  }
}
