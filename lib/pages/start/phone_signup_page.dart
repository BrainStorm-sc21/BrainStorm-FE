import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//회원가입 시 번호 인증 페이지 입니다.
class PhoneAuthForSignUpPage extends StatefulWidget {
  late double isHiddenAuthInput = 0; //0.0이 보이지 않음, 1.0이 보임
  late double isHiddenAuthButton = 0;
  PhoneAuthForSignUpPage({super.key});

  @override
  State<PhoneAuthForSignUpPage> createState() => _PhoneAuthForSignUpPageState();
}

class _PhoneAuthForSignUpPageState extends State<PhoneAuthForSignUpPage> {
  late final String phoneNumber;
  final TextEditingController _phoneEditingController = TextEditingController();
  final TextEditingController _authEditingController = TextEditingController();

  final _key = GlobalKey<FormState>();
  final bool _codeSent = false;
  late String _verificationId;
  late int? _resendToken;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    phoneNumber = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("번호인증"),
        backgroundColor: ColorStyles.mainColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: TextFormField(
                        controller: _phoneEditingController,
                        maxLength: 11,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: "번호를 - 없이 입력해주세요.",
                          hintStyle: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        FirebaseAuth auth = FirebaseAuth.instance;
                        print(_phoneEditingController.text);
                        await auth.verifyPhoneNumber(
                          //forceResendingToken: _resendToken,

                          phoneNumber: "+82${_phoneEditingController.text}",

                          codeAutoRetrievalTimeout: (String verificationId) {},

                          verificationCompleted:
                              (PhoneAuthCredential credential) async {
                            await auth.signInWithCredential(credential);
                          },

                          verificationFailed: (FirebaseException e) async {
                            print('verificationFailed 에러!!');
                          },

                          codeSent:
                              (String verificationId, int? resendToken) async {
                            setState(() {
                              _verificationId = verificationId;
                              _resendToken = resendToken;
                              widget.isHiddenAuthButton = 1;
                              widget.isHiddenAuthInput = 1;
                            });
                          },
                          timeout: const Duration(seconds: 60),
                        );
                      },
                      style: TextButton.styleFrom(
                          foregroundColor: ColorStyles.mainColor),
                      child: const Text('인증번호 받기'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: Opacity(
                    opacity: widget.isHiddenAuthInput,
                    child: TextFormField(
                      controller: _authEditingController,
                      maxLength: 6,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "인증번호를 입력해주세요",
                        hintStyle: const TextStyle(fontSize: 12),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: ColorStyles.borderColor, width: 1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: ColorStyles.borderColor, width: 1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: ColorStyles.borderColor, width: 1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Opacity(
                  opacity: widget.isHiddenAuthButton,
                  child: ElevatedButton(
                      onPressed: () async {
                        FirebaseAuth auth = FirebaseAuth.instance;

                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: _verificationId,
                                smsCode: _authEditingController.text);
                        await auth
                            .signInWithCredential(credential)
                            .then((value) {
                          Navigator.pop(context, _phoneEditingController.text);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorStyles.mainColor,
                      ),
                      child: const Text('인증하기')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class phoneInputUnit extends StatefulWidget {
//   final void Function(String phoneNumber) setPhoneNumber;
//   final void Function(String verificationId) setVerificationId;
//   late String? verificationId;
//   phoneInputUnit(
//       {super.key,
//       required this.setPhoneNumber,
//       required this.setVerificationId,
//       required this.verificationId});

//   @override
//   State<phoneInputUnit> createState() => _phoneInputUnitState();
// }

// class _phoneInputUnitState extends State<phoneInputUnit> {
//   final TextEditingController _phoneEditingController = TextEditingController();
//   late int? _resendToken;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           SizedBox(
//             width: MediaQuery.of(context).size.width * 0.5,
//             child: TextFormField(
//               controller: _phoneEditingController,
//               maxLength: 11,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(
//                 hintText: "번호를 - 없이 입력해주세요.",
//                 hintStyle: TextStyle(fontSize: 12),
//               ),
//             ),
//           ),
//           TextButton(
//             onPressed: () async {
//               FirebaseAuth auth = FirebaseAuth.instance;
//               print(_phoneEditingController.text);
//               await auth.verifyPhoneNumber(
//                 //forceResendingToken: _resendToken,

//                 phoneNumber: "+82${_phoneEditingController.text}",

//                 codeAutoRetrievalTimeout: (String verificationId) {},

//                 verificationCompleted: (PhoneAuthCredential credential) async {
//                   await auth.signInWithCredential(credential);
//                 },

//                 verificationFailed: (FirebaseException e) async {
//                   print('verificationFailed 에러!!');
//                 },

//                 codeSent: (String verificationId, int? resendToken) async {
//                   widget.verificationId = verificationId;
//                   _resendToken = resendToken;
//                 },
//               );
//               setState(() {
//                 widget.setPhoneNumber(_phoneEditingController.text);
//                 widget.setVerificationId(widget.verificationId!);
//               });
//             },
//             style: TextButton.styleFrom(foregroundColor: ColorStyles.mainColor),
//             child: const Text('인증번호 받기'),
//           ),
//         ],
//       ),
//     );
//   }
// }
