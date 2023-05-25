import 'package:brainstorm_meokjang/pages/chat/chat_page.dart';
import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:brainstorm_meokjang/widgets/customProgressBar.dart';
import 'package:flutter/material.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  List<String> dealInfo = ["거래 내역", "받은 후기", "보낸 후기", "관심 거래"];
  List<String> settings = ["알림 설정", "사용자 설정", "기타"];
  List<List<String>> settingNames = [
    ["알림 및 소리", "방해금지 시간 설정"],
    ["계정 / 정보 관리", "차단 사용자 관리", "게시글 미노출 사용자 관리", "기타 설정"],
    ["공지사항", "언어 설정", "버전 정보", "로그아웃", "회원 탈퇴"]
  ];
  Map<String, dynamic> settingDetails = {
    "알림 및 소리": const ChatPage(),
    "방해금지 시간 설정": const ChatPage(),
    "계정 / 정보 관리": const ChatPage(),
    "차단 사용자 관리": const ChatPage(),
    "게시글 미노출 사용자 관리": const ChatPage(),
    "기타 설정": const ChatPage(),
    "공지사항": const ChatPage(),
    "언어 설정": const ChatPage(),
    "버전 정보": const ChatPage(),
    "로그아웃": const ChatPage(),
    "회원 탈퇴": const ChatPage()
  };

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            // shape: const RoundedRectangleBorder(
            //     borderRadius: BorderRadius.only(
            //         bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50))),
            elevation: 0,
            backgroundColor: ColorStyles.mainColor,
            expandedHeight: MediaQuery.of(context).size.height * 0.43,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 30),
                      child: Text(
                        "먹짱",
                        style: TextStyle(
                            color: ColorStyles.white, fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Text(
                      "내 신뢰도",
                      style: TextStyle(
                          color: ColorStyles.white, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Column(
                      children: [
                        Container(
                          alignment: const FractionalOffset(43 / 50, 1 - 43 / 50),
                          child: FractionallySizedBox(
                            child: Column(
                              children: [
                                const Text("4.3", style: TextStyle(color: ColorStyles.lightYellow)),
                                const SizedBox(height: 3),
                                Image.asset('assets/images/inverted_triangle1.png'),
                              ],
                            ),
                          ),
                        ),
                        const CustomProgressBar(
                          paddingHorizontal: 5,
                          currentPercent: 43,
                          maxPercent: 50,
                          lineHeight: 12,
                          firstColor: ColorStyles.lightYellow,
                          secondColor: ColorStyles.lightYellow,
                        ),
                      ],
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List<Widget>.generate(4, (index) {
                          return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Container(
                                  width: 85,
                                  height: 70,
                                  decoration: BoxDecoration(
                                      color: ColorStyles.lightmainColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        dealInfo[index],
                                        style: const TextStyle(
                                            color: ColorStyles.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const Text(
                                        '10',
                                        style: TextStyle(color: ColorStyles.white, fontSize: 18),
                                      )
                                    ],
                                  )));
                        }))
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Stack(
                  children: [
                    index == 0
                        ? SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 130,
                            child: Image.asset(
                              'assets/images/myPagebackground.png',
                              fit: BoxFit.fill,
                            ),
                          )
                        // ? Image.asset(
                        //     'assets/images/myPagebackground.png',
                        //   )
                        : Container(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorStyles.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                                color: ColorStyles.shadowColor, spreadRadius: 5, blurRadius: 4),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(settings[index],
                                  style: const TextStyle(
                                      color: ColorStyles.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w800)),
                              const SizedBox(height: 8),
                              Column(
                                  children: List<Widget>.generate(settingNames[index].length, (i) {
                                return SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                          alignment: Alignment.centerLeft,
                                          padding: const EdgeInsets.only(left: 0)),
                                      onPressed: () {
                                        print("알림 및 소리 눌림");
                                      },
                                      child: Text(
                                        settingNames[index][i],
                                        style: const TextStyle(color: ColorStyles.textColor),
                                      ),
                                    ));
                              }))
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
              childCount: 3,
            ),
          )
        ],
      ),
    );
  }
}
