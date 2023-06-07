import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:brainstorm_meokjang/widgets/customProgressBar.dart';
import 'package:flutter/material.dart';

class OtherProfile extends StatelessWidget {
  const OtherProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "프로필",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          centerTitle: true,
          backgroundColor: ColorStyles.mainColor,
          elevation: 0.3,
        ),
        body: Stack(children: [
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
                    padding: const EdgeInsets.only(top: 30, bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: const Text(
                              "상대방 닉네임",
                              style: TextStyle(fontSize: 25),
                            )),
                      ],
                    ),
                  ),
                  const Text(
                    "신뢰도",
                    style: TextStyle(
                        color: ColorStyles.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Column(
                    children: [
                      Container(
                        alignment: const FractionalOffset(60 / 100, 1 - (60 / 100)),
                        child: FractionallySizedBox(
                          child: Column(
                            children: [
                              Text(60.toString(),
                                  style: const TextStyle(
                                      color: ColorStyles.lightYellow, fontSize: 15)),
                              const SizedBox(height: 3),
                              Image.asset('assets/images/inverted_triangle1.png'),
                            ],
                          ),
                        ),
                      ),
                      const CustomProgressBar(
                        paddingHorizontal: 5,
                        currentPercent: 60,
                        maxPercent: 100,
                        lineHeight: 12,
                        firstColor: ColorStyles.lightYellow,
                        secondColor: ColorStyles.lightYellow,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorStyles.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(color: ColorStyles.shadowColor, spreadRadius: 5, blurRadius: 4),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                                children: List<Widget>.generate(2, (i) {
                              return SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                        alignment: Alignment.centerLeft,
                                        padding: const EdgeInsets.only(left: 0)),
                                    onPressed: () {
                                      print("알림 및 소리 눌림");
                                    },
                                    child: const Text(
                                      "판매내역",
                                      style: TextStyle(
                                          color: ColorStyles.textColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15),
                                    ),
                                  ));
                            }))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
