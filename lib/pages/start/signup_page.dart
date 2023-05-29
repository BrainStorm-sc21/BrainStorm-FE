import 'dart:async';

import 'package:brainstorm_meokjang/app_pages_container.dart';
import 'package:brainstorm_meokjang/models/user.dart';
import 'package:brainstorm_meokjang/pages/start/phone_signup_page.dart';
import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:brainstorm_meokjang/widgets/sns_webView_widget.dart';
import 'package:flutter/material.dart';
import 'package:kpostal/kpostal.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late User user;
  bool isValid = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    user = User(
        userName: "",
        phoneNumber: null,
        snsType: null,
        snsKey: null,
        location: "",
        latitude: 0.0,
        longitude: 0.0,
        gender: null);
  }

  void checkValid() {
    if (user.userName != "" &&
        user.phoneNumber != null &&
        user.location != "" &&
        user.gender != null) {
      setState(() {
        isValid = true;
      });
    } else {
      setState(() {
        isValid = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setNickname(String value) => setState(() {
        user.userName = value;
        checkValid();
      });
  void setGender(int value) => setState(() {
        user.gender = value;
        checkValid();
      });
  void setAddress(String location, double latitude, double longitude) =>
      setState(() {
        user.location = location;
        user.latitude = latitude;
        user.longitude = longitude;
        checkValid();
      });
  void sendPhoneNumber(String phoneNumber) => setState(() {
        user.phoneNumber = phoneNumber;
        checkValid();
      });

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("회원가입"),
          backgroundColor: ColorStyles.mainColor,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Container(
            child: ListView(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    NicknameField(setNickname: setNickname),
                    GenderField(setGender: setGender),
                    PositionField(setAddress: setAddress),
                    AuthField(sendPhoneNumber: sendPhoneNumber),
                    SizedBox(
                        width: deviceWidth * 0.8,
                        child: AbsorbPointer(
                          absorbing: !isValid,
                          child: ElevatedButton(
                              onPressed: () async {
                                int userId = await requestSignUp(user);

                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        CompleteSignUpImage(userId: userId),
                                  ),
                                  (route) => false,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: (isValid)
                                    ? ColorStyles.mainColor
                                    : ColorStyles.grey,
                              ),
                              child: const Text("회원가입하기")),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NicknameField extends StatefulWidget {
  final void Function(String value) setNickname;
  const NicknameField({super.key, required this.setNickname});

  @override
  State<NicknameField> createState() => _NicknameFieldState();
}

class _NicknameFieldState extends State<NicknameField> {
  final TextEditingController _nicknameController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nicknameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: SizedBox(
                width: deviceWidth * 0.8,
                child: const Text(
                  "닉네임",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ),
            SizedBox(
              width: deviceWidth * 0.8,
              child: Form(
                child: TextFormField(
                  controller: _nicknameController,
                  maxLength: 10,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: "2글자 이상 10글자 이하로 입력해주세요.",
                    hintStyle: TextStyle(fontSize: 12),
                  ),
                  validator: (value) {
                    if (value!.length < 2) {
                      return '2글자 이상 입력해주세요.';
                    }
                    return null;
                  },
                  onChanged: (value) => widget.setNickname(value),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GenderField extends StatefulWidget {
  final void Function(int value) setGender;
  const GenderField({super.key, required this.setGender});

  @override
  State<GenderField> createState() => _GenderFieldState();
}

class _GenderFieldState extends State<GenderField> {
  bool isMan = false;
  bool isWoman = false;
  late List<bool> isSelected;

  @override
  void initState() {
    isSelected = [isMan, isWoman];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: SizedBox(
                width: deviceWidth * 0.8,
                child: const Text(
                  "성별",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ),
            ToggleButtons(
              fillColor: ColorStyles.mainColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(4),
              isSelected: isSelected,
              constraints: const BoxConstraints(minWidth: 120, minHeight: 38),
              onPressed: toggleSelect,
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "남",
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "여",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void toggleSelect(value) {
    if (value == 0) {
      isMan = true;
      isWoman = false;
    } else {
      isMan = false;
      isWoman = true;
    }
    setState(() {
      isSelected = [isMan, isWoman];
      widget.setGender(value);
    });
  }
}

class PositionField extends StatefulWidget {
  final void Function(String location, double latitude, double longitude)
      setAddress;
  const PositionField({super.key, required this.setAddress});

  @override
  State<PositionField> createState() => _PositionFieldState();
}

class _PositionFieldState extends State<PositionField> {
  String posText = "내 주소를 입력해주세요.";
  Color posColor = Colors.grey;
  double posFontSize = 12;

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: SizedBox(
                width: deviceWidth * 0.8,
                child: const Text(
                  "주소",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: const BoxDecoration(
                      border: Border(
                    bottom: BorderSide(color: Colors.grey),
                  )),
                  width: deviceWidth * 0.65,
                  height: 35,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 7),
                    child: Text(
                      posText,
                      textAlign: TextAlign.start,
                      style: TextStyle(color: posColor, fontSize: posFontSize),
                    ),
                  ),
                ),
                SizedBox(
                  width: deviceWidth * 0.15,
                  height: 35,
                  child: ElevatedButton(
                    onPressed: () async {
                      Kpostal result = await Navigator.push(context,
                          MaterialPageRoute(builder: (_) => KpostalView()));
                      setState(() {
                        posText = result.address;
                        posColor = Colors.black;
                        posFontSize = 14;
                        widget.setAddress(result.address, result.latitude!,
                            result.longitude!);
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                    ),
                    child: const Text(
                      "검색",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class AuthField extends StatefulWidget {
  final void Function(String phoneNumber) sendPhoneNumber;
  const AuthField({super.key, required this.sendPhoneNumber});

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  String? phoneNumber;
  bool isCompleteAuth = false;

  void setPhoneNumber(String phoneNumber) => setState(() {
        phoneNumber = phoneNumber;
        isCompleteAuth = true;
      });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Center(
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        width: 110,
                                        height: 70,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const NaverWebView()),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                ColorStyles.mainColor,
                                          ),
                                          child: const Text("Naver로\n인증하기"),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        width: 110,
                                        height: 70,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const KakaoWebView()),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                ColorStyles.mainColor,
                                          ),
                                          child: const Text("Kakao로\n인증하기"),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 0),
                                child: SizedBox(
                                  height: 40,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    style: TextButton.styleFrom(
                                      foregroundColor: ColorStyles.mainColor,
                                    ),
                                    child: const Text("확인"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: ColorStyles.mainColor,
                  ),
                  child: const Text("sns 인증"),
                ),
                AbsorbPointer(
                  absorbing: isCompleteAuth,
                  child: TextButton(
                    onPressed: () async {
                      String phoneNumber = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PhoneAuthForSignUpPage()),
                      );
                      setState(() {
                        widget.sendPhoneNumber(phoneNumber);
                      });
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: (isCompleteAuth)
                          ? ColorStyles.grey
                          : ColorStyles.mainColor,
                      side: BorderSide(
                          color: (isCompleteAuth)
                              ? ColorStyles.mainColor
                              : ColorStyles.white),
                    ),
                    child: const Text("번호 인증"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CompleteSignUpImage extends StatefulWidget {
  final int userId;
  const CompleteSignUpImage({
    super.key,
    required this.userId,
  });

  @override
  State<CompleteSignUpImage> createState() => _CompleteSignUpImageState();
}

class _CompleteSignUpImageState extends State<CompleteSignUpImage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 1500), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => AppPagesContainer(userId: widget.userId),
        ),
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/images/completeSignUp.png'),
        fit: BoxFit.fill,
      )),
    );
  }
}
