import 'package:brainstorm_meokjang/models/user.dart';
import 'package:brainstorm_meokjang/pages/start/phone_login_page.dart';
import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:brainstorm_meokjang/widgets/sns_webView_widget.dart';
import 'package:flutter/material.dart';
import 'package:kpostal/kpostal.dart';

bool valid_nickname = false;
bool valid_gender = false;
bool valid_address = false;
bool valid_auth = false;

late String userName;
late int gender; //남 - 0, 여 - 1
String location = '';
double? latitude;
double? longitude;

String? phoneNumber;
String? snsType;
String? snsKey;

User user =
    User(userName: '', location: '', latitude: 0.0, longitude: 0.0, gender: 0);

final _nicknameController = TextEditingController();

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
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
                  const NicknameField(),
                  const GenderField(),
                  const PositionField(),
                  const AuthField(),
                  SizedBox(
                    width: deviceWidth * 0.8,
                    child: ElevatedButton(
                      onPressed: () {
                        print(postSignUp(user));

                        //print('http 요청');
                        // print('userName: ${_nicknameController.text}');
                        // print('gender: ${user.gender}');
                        // print(
                        //     'location: ${user.location}, latitude: ${user.latitude}, longitude: ${user.longitude}');
                        // print('phoneNumber: ${user.phoneNumber}');
                        // print(
                        //     'snsType: ${user.snsType}, snsKey: ${user.snsKey}');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorStyles.mainColor,
                      ),
                      child: const Text(
                        "회원가입하기",
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NicknameField extends StatefulWidget {
  const NicknameField({super.key});

  @override
  State<NicknameField> createState() => _NicknameFieldState();
}

class _NicknameFieldState extends State<NicknameField> {
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
                  keyboardType: TextInputType.number,
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
  const GenderField({super.key});

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
      user.gender = 0;
      isMan = true;
      isWoman = false;
    } else {
      user.gender = 1;
      isMan = false;
      isWoman = true;
    }
    setState(() {
      isSelected = [isMan, isWoman];
    });
  }
}

class PositionField extends StatefulWidget {
  const PositionField({super.key});

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
                      //위치, 위도, 경도
                      // print("위치: ${result.address}");
                      // print("위도: ${result.latitude}");
                      // print("경도: ${result.longitude}");
                      user.location = result.address;
                      user.latitude = result.latitude;
                      user.longitude = result.longitude;
                      setState(() {
                        posText = result.address;
                        posColor = Colors.black;
                        posFontSize = 14;
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
  const AuthField({super.key});

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
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
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PhoneLoginPage()),
                    );
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: ColorStyles.mainColor,
                  ),
                  child: const Text("번호 인증"),
                ),
              ],
            ),
            Container(
              child: const Text(
                "인증 미완료",
                style: TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
