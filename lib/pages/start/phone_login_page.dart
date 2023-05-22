import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

final TextEditingController _phoneController = TextEditingController();
final TextEditingController _smsCodeController = TextEditingController();

//로그인 시, 번호 인증 페이지입니다.
class PhoneLoginPage extends StatefulWidget {
  const PhoneLoginPage({super.key});

  @override
  State<PhoneLoginPage> createState() => _PhoneLoginPageState();
}

class _PhoneLoginPageState extends State<PhoneLoginPage> {
  final _key = GlobalKey<FormState>();
  final bool _codeSent = false;
  late String _verificationId;

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
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
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
                      print(_phoneController.text);
                      await auth.verifyPhoneNumber(
                        //forceResendingToken: _resendToken,

                        phoneNumber: "+82${_phoneController.text}",

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
                            builder: (context) => PhoneAuthPage(
                                  phoneNumber: _phoneController.text,
                                  verificationId: _verificationId,
                                )),
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
  final String phoneNumber;
  late String verificationId;
  PhoneAuthPage(
      {super.key, required this.phoneNumber, required this.verificationId});

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
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: TextFormField(
                  controller: _smsCodeController,
                  decoration: const InputDecoration(
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
                              verificationId: widget.verificationId,
                              smsCode: _smsCodeController.text);
                      await auth
                          .signInWithCredential(credential)
                          .then((value) => print(value));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ColorStyles.mainColor),
                    child: const Text("인증하기"),
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
