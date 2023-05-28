import 'package:brainstorm_meokjang/models/user.dart';
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
  final TextEditingController _nickNameController = TextEditingController();
  final FocusNode _textFocus = FocusNode();

  List<String> dealInfo = ["거래 내역", "받은 후기", "보낸 후기", "등록 거래"];
  List<String> settings = ["알림 설정", "사용자 설정", "기타"];
  List<List<String>> settingNames = [
    ["알림 및 소리", "방해금지 시간 설정"],
    ["계정 / 정보 관리", "차단 사용자 관리", "게시글 미노출 사용자 관리", "기타 설정"],
    ["공지사항", "언어 설정", "버전 정보", "로그아웃", "회원 탈퇴"]
  ];

  Map<String, dynamic> settingDetails = {
    "알림 및 소리": '',
    "방해금지 시간 설정": '',
    "계정 / 정보 관리": '',
    "차단 사용자 관리": '',
    "게시글 미노출 사용자 관리": '',
    "기타 설정": '',
    "공지사항": '',
    "언어 설정": '',
    "버전 정보": '',
    "로그아웃": '',
    "회원 탈퇴": '',
  };

  Future getUserName() async {
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

  @override
  void initState() {
    getUserName();
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
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: ColorStyles.mainColor,
            expandedHeight: MediaQuery.of(context).size.height * 0.46,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
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
                                    Popups.popSimpleDialog(context,
                                        title: _nickNameController.text,
                                        body: "닉네임이 성공적으로 변경되었어요!");
                                    setState(() {
                                      isClickedText = true;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                      border: InputBorder.none, counterText: ''),
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
                                Navigator.push(context,MaterialPageRoute(builder: (context) => const PushList()));
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
                      padding: const EdgeInsets.only(bottom: 30),
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
                          color: ColorStyles.white, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Column(
                      children: [
                        Container(
                          alignment: const FractionalOffset(43 / 100, 1 - 43 / 100),
                          child: FractionallySizedBox(
                            child: Column(
                              children: [
                                const Text("43",
                                    style: TextStyle(color: ColorStyles.lightYellow, fontSize: 15)),
                                const SizedBox(height: 3),
                                Image.asset('assets/images/inverted_triangle1.png'),
                              ],
                            ),
                          ),
                        ),
                        const CustomProgressBar(
                          paddingHorizontal: 5,
                          currentPercent: 43,
                          maxPercent: 100,
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
                              padding: const EdgeInsets.only(top: 20),
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
