import 'package:brainstorm_meokjang/app_pages_container.dart';
import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

final _key = GlobalKey<FormState>();
final TextEditingController _phoneController = TextEditingController();
final TextEditingController _smsCodeController = TextEditingController();
const bool _codeSent = false;
late String _verificationId;

class PhoneLoginPage extends StatefulWidget {
  const PhoneLoginPage({super.key});

  @override
  State<PhoneLoginPage> createState() => _PhoneLoginPageState();
}

class _PhoneLoginPageState extends State<PhoneLoginPage> {
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("번호인증"),
        backgroundColor: ColorStyles.mainColor,
      ),
      body: Center(
        child: SizedBox(
          height: deviceHeight * 0.5,
          width: deviceWidth * 0.8,
          child: Column(
            children: [
              const Text(
                "서비스 이용을 위해 \n번호를 입력해주세요.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: ColorStyles.mainColor),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 50),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "휴대폰 번호(-없이 숫자만 입력)",
                  ),
                  keyboardType: TextInputType.phone,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  width: deviceWidth * 0.8,
                  child: ElevatedButton(
                    onPressed: () async {
                      FirebaseAuth auth = FirebaseAuth.instance;

                      await auth.verifyPhoneNumber(
                        //forceResendingToken: _resendToken,

                        phoneNumber: "+82010-4401-0159",

                        codeAutoRetrievalTimeout: (String verificationId) {},

                        verificationCompleted:
                            (PhoneAuthCredential credential) async {
                          await auth.signInWithCredential(credential);
                        },

                        verificationFailed: (FirebaseException e) async {
                          logger.e(e.message);
                          setState(() {});
                        },

                        codeSent: (String verificationId,
                            int? forceResendingToken) async {
                          setState(() {});
                        },
                      );

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PhoneAuthPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ColorStyles.mainColor),
                    child: const Text("인증 문자 받기"),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PhoneAuthPage extends StatefulWidget {
  const PhoneAuthPage({super.key});

  @override
  State<PhoneAuthPage> createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("번호인증"),
        backgroundColor: ColorStyles.mainColor,
      ),
      body: Center(
        child: SizedBox(
          height: deviceHeight * 0.5,
          width: deviceWidth * 0.8,
          child: Column(
            children: [
              const Text(
                "인증번호가 \n문자로 전송되었습니다.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: ColorStyles.mainColor),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 50),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "인증번호 입력",
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  width: deviceWidth * 0.8,
                  child: ElevatedButton(
                    onPressed: () async {
                      FirebaseAuth auth = FirebaseAuth.instance;

                      PhoneAuthCredential credential =
                          PhoneAuthProvider.credential(
                              verificationId: _verificationId,
                              smsCode: _smsCodeController.text);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AppPagesContainer()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ColorStyles.mainColor),
                    child: const Text("인증하고 로그인하기"),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

TextFormField phoneNumberInput() {
  return TextFormField(
    controller: _phoneController,
    autofocus: true,
    validator: (val) {
      if (val!.isEmpty) {
        return 'The input is empty.';
      } else {
        return null;
      }
    },
    keyboardType: TextInputType.phone,
    decoration: const InputDecoration(
      border: OutlineInputBorder(),
      hintText: 'Input your phone number.',
      labelText: 'Phone Number',
      labelStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
