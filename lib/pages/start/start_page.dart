import 'package:brainstorm_meokjang/pages/start/phone_login_page.dart';
import 'package:brainstorm_meokjang/pages/start/signup_page.dart';
import 'package:brainstorm_meokjang/utilities/Colors.dart';
import 'package:brainstorm_meokjang/widgets/sns_webView_widget.dart';
import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("먹장!"),
        backgroundColor: ColorStyles.mainColor,
      ),
      body: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(50, 100, 50, 0),
            child: Column(
              children: [
                Container(
                  child: Image.asset(
                    'assets/images/임시온보딩화면2.png',
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 30),
                //   child: SizedBox(
                //     width: deviceWidth * 0.85,
                //     child: ElevatedButton(
                //       onPressed: () {},
                //       style: ElevatedButton.styleFrom(
                //         backgroundColor: Colors.white,
                //       ),
                //       child: Row(
                //         children: [
                //           Image.asset(
                //             'assets/images/google.png',
                //             width: 15,
                //             height: 15,
                //           ),
                //           const Text(
                //             "Google로 로그인",
                //             style: TextStyle(color: Colors.black),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: SizedBox(
                    width: deviceWidth * 0.85,
                    child: ElevatedButton(
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const KakaoWebView()),
                        );
                        print("클릭!");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow,
                      ),
                      child: Row(
                        children: [
                          Center(
                            child: Image.asset(
                              'assets/images/kakao.png',
                              width: 20,
                              height: 20,
                            ),
                          ),
                          const Text(
                            "Kakao로 로그인",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: deviceWidth * 0.85,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NaverWebView()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/naver.png',
                          width: 20,
                          height: 20,
                        ),
                        const Text(
                          "Naver로 로그인",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: deviceWidth * 0.85,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PhoneLoginPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(),
                    child: const Row(
                      children: [
                        Icon(Icons.call),
                        Text("번호인증으로 로그인"),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 70),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpPage()),
                      );
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black,
                    ),
                    child: const Text("회원가입"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
