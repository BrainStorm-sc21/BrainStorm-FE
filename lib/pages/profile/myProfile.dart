import 'package:brainstorm_meokjang/models/user.dart';
import 'package:brainstorm_meokjang/pages/profile/dealHistory.dart';
import 'package:brainstorm_meokjang/pages/profile/reviewHistory.dart';
import 'package:brainstorm_meokjang/pages/pushMessage/push_list_page.dart';
import 'package:brainstorm_meokjang/providers/userInfo_controller.dart';
import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:brainstorm_meokjang/utilities/popups.dart';
import 'package:brainstorm_meokjang/widgets/customProgressBar.dart';
import 'package:brainstorm_meokjang/widgets/rounded_outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyProfile extends StatefulWidget {
  int userId;
  MyProfile({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  bool isClickedModifyButton = false;
  double reliability = 0;
  final UserInfoController _userInfoController = Get.put(UserInfoController());

  List<String> settings = ["거래 내역", "기타"];
  List<List<String>> settingNames = [
    ["보낸/받은 후기", "내 게시물"],
    ["로그아웃", "회원 탈퇴"]
  ];

  Map<String, dynamic> settingDetails = {
    "보낸/받은 후기": '',
    "내 게시물": '',
    "로그아웃": '',
    "회원 탈퇴": '',
  };

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
                child: Image.asset(
                  'assets/images/myPagebackground.png',
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Obx(
                                  () {
                                    if (_userInfoController.isLoading) {
                                      return const CircularProgressIndicator();
                                    } else {
                                      return Text(
                                        _userInfoController.userName,
                                        style: const TextStyle(
                                            fontSize: 30.0,
                                            fontWeight: FontWeight.bold,
                                            height: 1,
                                            color: ColorStyles.white,
                                            overflow: TextOverflow.ellipsis),
                                      );
                                    }
                                  },
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const PushList()));
                                  },
                                  icon: const Icon(
                                    Icons.notifications,
                                    color: ColorStyles.white,
                                    size: 35,
                                  )),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: RoundedOutlinedButton(
                              height: 23,
                              backgroundColor: ColorStyles.lightmainColor,
                              borderColor: ColorStyles.lightmainColor,
                              foregroundColor: ColorStyles.white,
                              onPressed: () {
                                Popups.changeUserInfo(context, widget.userId);
                              },
                              fontSize: 13,
                              text: "프로필 수정 >"),
                        ),
                        const Text(
                          "내 신뢰도",
                          style: TextStyle(
                              color: ColorStyles.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Obx(
                          () => Column(
                            children: [
                              Container(
                                alignment: FractionalOffset(
                                    _userInfoController.reliability / 100,
                                    (100 - _userInfoController.reliability) /
                                        100),
                                child: FractionallySizedBox(
                                  child: Column(
                                    children: [
                                      Text(
                                          _userInfoController.reliability
                                              .toString(),
                                          style: const TextStyle(
                                              color: ColorStyles.lightYellow,
                                              fontSize: 15)),
                                      const SizedBox(height: 3),
                                      Image.asset(
                                          'assets/images/inverted_triangle1.png'),
                                    ],
                                  ),
                                ),
                              ),
                              CustomProgressBar(
                                paddingHorizontal: 3,
                                currentPercent: _userInfoController.reliability,
                                maxPercent: 100,
                                lineHeight: 12,
                                firstColor: ColorStyles.lightYellow,
                                secondColor: ColorStyles.lightYellow,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Container(
                            decoration: BoxDecoration(
                              color: ColorStyles.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    color: ColorStyles.shadowColor,
                                    spreadRadius: 5,
                                    blurRadius: 4),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("거래 내역",
                                      style: TextStyle(
                                          color: ColorStyles.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w800)),
                                  const SizedBox(height: 8),
                                  Column(
                                      children: List<Widget>.generate(2, (i) {
                                    return SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                              alignment: Alignment.centerLeft,
                                              padding: const EdgeInsets.only(
                                                  left: 0)),
                                          onPressed: () {
                                            (i == 0)
                                                ? Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ReviewHistoryPage(
                                                              userId:
                                                                  widget.userId,
                                                            )),
                                                  )
                                                : Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            DealHistoryPage(
                                                              userId:
                                                                  widget.userId,
                                                            )),
                                                  );
                                          },
                                          child: Text(
                                            settingNames[0][i],
                                            style: const TextStyle(
                                                color: ColorStyles.textColor),
                                          ),
                                        ));
                                  }))
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Container(
                              decoration: BoxDecoration(
                                color: ColorStyles.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                      color: ColorStyles.shadowColor,
                                      spreadRadius: 5,
                                      blurRadius: 4),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("기타",
                                        style: TextStyle(
                                            color: ColorStyles.black,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w800)),
                                    const SizedBox(height: 8),
                                    Column(
                                        children: List<Widget>.generate(2, (i) {
                                      return SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: TextButton(
                                            style: TextButton.styleFrom(
                                                alignment: Alignment.centerLeft,
                                                padding: const EdgeInsets.only(
                                                    left: 0)),
                                            onPressed: () {
                                              if (i == 0) {
                                                showLogoutDialog(context);
                                              } else {
                                                showSignOutDialog(
                                                    context, widget.userId);
                                              }
                                            },
                                            child: Text(
                                              settingNames[1][i],
                                              style: const TextStyle(
                                                  color: ColorStyles.textColor),
                                            ),
                                          ));
                                    }))
                                  ],
                                ),
                              ),
                            )),
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//Regrigerator의 다이얼로그를 활용
void showLogoutDialog(context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text("정말로 로그아웃 하시겠습니까?"),
          actions: [
            // 취소 버튼
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("취소"),
            ),
            // 확인 버튼
            TextButton(
              onPressed: () {
                print('로그아웃 시도');
                requestLogout(context);
              },
              child: const Text(
                "확인",
                style: TextStyle(color: Colors.pink),
              ),
            ),
          ],
        );
      });
}

void showSignOutDialog(context, userId) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text(
            "정말로 회원탈퇴를 하시겠습니까?\n유저 데이터가 전부 삭제됩니다.",
            style: TextStyle(fontSize: 18),
          ),
          actions: [
            // 취소 버튼
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("취소"),
            ),
            // 확인 버튼
            TextButton(
              onPressed: () {
                print('회원탈퇴 시도');
                // requestSignOut(context, userId);
              },
              child: const Text(
                "확인",
                style: TextStyle(color: Colors.pink),
              ),
            ),
          ],
        );
      });
}
