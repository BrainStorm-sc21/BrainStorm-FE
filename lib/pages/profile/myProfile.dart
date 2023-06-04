import 'package:brainstorm_meokjang/models/user.dart';
import 'package:brainstorm_meokjang/pages/profile/dealHistory.dart';
import 'package:brainstorm_meokjang/pages/pushMessage/push_list_page.dart';
import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:brainstorm_meokjang/utilities/domain.dart';
import 'package:brainstorm_meokjang/utilities/popups.dart';
import 'package:brainstorm_meokjang/widgets/customProgressBar.dart';
import 'package:brainstorm_meokjang/widgets/rounded_outlined_button.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

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
  bool isClickedText = false;
  double reliability = 0;
  final TextEditingController _nickNameController = TextEditingController();
  final FocusNode _textFocus = FocusNode();

  List<String> settings = ["거래 내역", "기타"];
  List<List<String>> settingNames = [
    ["준/받은 후기", "내 게시물"],
    ["로그아웃", "회원 탈퇴"]
  ];

  Map<String, dynamic> settingDetails = {
    "준/받은 후기": '',
    "내 게시물": '',
    "로그아웃": '',
    "회원 탈퇴": '',
  };

  Future getUserInfo() async {
    Dio dio = Dio();

    dio.options
      ..baseUrl = baseURI
      ..connectTimeout = const Duration(seconds: 5)
      ..receiveTimeout = const Duration(seconds: 10);
    try {
      Response resp = await dio.get("/users/${widget.userId}");

      User user = User.fromJson(resp.data);

      if (resp.data['status'] == 200) {
        print('회원 불러오기 성공!!');
        print(resp.data);
        setState(() {
          _nickNameController.text = user.userName;
          reliability = user.reliability!;
        });
      } else if (resp.data['status'] == 400) {
        print('회원 불러오기 실패!!');
        throw Exception('Failed to send data [${resp.statusCode}]');
      }
    } catch (e) {
      Exception(e);
    } finally {
      dio.close();
    }
    return false;
  }

  void modifyUserInfo() async {
    Dio dio = Dio();
    dio.options
      ..baseUrl = baseURI
      ..connectTimeout = const Duration(seconds: 5)
      ..receiveTimeout = const Duration(seconds: 10);

    final data = {
      "userName": _nickNameController.text,
    };
    print("데이터");
    print(data);

    try {
      Response res = await dio.put("/users/${widget.userId}", data: data);

      if (!mounted) return;
      if (res.statusCode == 200) {
        Popups.popSimpleDialog(context,
            title: _nickNameController.text, body: "닉네임이 성공적으로 변경되었어요!");
      } else {
        throw Exception('Failed to send data [${res.statusCode}]');
      }
    } on DioError catch (err) {
      Popups.popSimpleDialog(
        context,
        title: '${err.type}',
        body: '${err.message}',
      );
    } catch (err) {
      debugPrint('$err');
    } finally {
      dio.close();
    }
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _nickNameController.dispose();
    _textFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: AbsorbPointer(
                                absorbing: isClickedText,
                                child: TextField(
                                    controller: _nickNameController,
                                    focusNode: _textFocus,
                                    onSubmitted: (value) {
                                      modifyUserInfo();
                                      setState(() {
                                        isClickedText = true;
                                      });
                                    },
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        counterText: ''),
                                    style: const TextStyle(
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.bold,
                                        height: 1,
                                        color: ColorStyles.white,
                                        overflow: TextOverflow.ellipsis),
                                    maxLength: 20),
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
                              setState(() {
                                isClickedText = isClickedText ? false : true;
                              });
                              _textFocus.requestFocus();
                            },
                            fontSize: 13,
                            text: "닉네임 수정 >"),
                      ),
                      const Text(
                        "내 신뢰도",
                        style: TextStyle(
                            color: ColorStyles.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Column(
                        children: [
                          Container(
                            alignment: FractionalOffset(
                                reliability / 100, 1 - (reliability / 100)),
                            child: FractionallySizedBox(
                              child: Column(
                                children: [
                                  Text(reliability.toString(),
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
                            paddingHorizontal: 5,
                            currentPercent: reliability,
                            maxPercent: 100,
                            lineHeight: 12,
                            firstColor: ColorStyles.lightYellow,
                            secondColor: ColorStyles.lightYellow,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
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
                                      width: MediaQuery.of(context).size.width,
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                            alignment: Alignment.centerLeft,
                                            padding:
                                                const EdgeInsets.only(left: 0)),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DealHistoryPage(
                                                      userId: widget.userId,
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
                                      width: MediaQuery.of(context).size.width,
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                            alignment: Alignment.centerLeft,
                                            padding:
                                                const EdgeInsets.only(left: 0)),
                                        onPressed: () {
                                          if (i == 0) {
                                            showLogoutDialog(context);
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
                        ),
                      )
                    ]),
              ),
            ),
          ],
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
