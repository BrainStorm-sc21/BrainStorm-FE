import 'package:brainstorm_meokjang/utilities/Colors.dart';
import 'package:flutter/material.dart';
import 'package:kpostal/kpostal.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
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

class NicknameField extends StatelessWidget {
  const NicknameField({super.key});

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
              child: const TextField(
                decoration: InputDecoration(
                  hintText: "2~10자 이내로 입력해주세요",
                  hintStyle: TextStyle(fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GenderField extends StatelessWidget {
  const GenderField({super.key});

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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: deviceWidth * 0.4,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.blue,
                      side: const BorderSide(color: Colors.grey),
                    ),
                    child: const Text("남"),
                  ),
                ),
                SizedBox(
                  width: deviceWidth * 0.4,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.grey),
                    ),
                    child: const Text("여"),
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
                      print("위치: ${result.address}");
                      print("위도: ${result.latitude}");
                      print("경도: ${result.longitude}");
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

class AuthField extends StatelessWidget {
  const AuthField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: ColorStyles.mainColor,
              ),
              child: const Text("sns 인증"),
            ),
            // TextButton(
            //   onPressed: () {},
            //   child: Text("구글 인증"),
            //   style: TextButton.styleFrom(
            //     primary: ColorStyles.mainColor,
            //   ),
            // ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: ColorStyles.mainColor,
              ),
              child: const Text("번호 인증"),
            ),
          ],
        ),
      ),
    );
  }
}
