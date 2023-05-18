import 'package:brainstorm_meokjang/pages/deal/detail/deal_detail_page.dart';
import 'package:brainstorm_meokjang/utilities/Colors.dart';
import 'package:brainstorm_meokjang/widgets/go_to_post/go_to_post_widgets.dart';
import 'package:brainstorm_meokjang/widgets/rounded_outlined_button.dart';
import 'package:flutter/material.dart';

class Popups {
  // static void checkSignUp(context, type) {
  //   showDialog(context: context, builder: (context) {
  //     return Dialog(
  //       shape: ,
  //     )
  //   });
  // }

  static void goToPost(context, type) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: width * 0.8,
            height: height * 0.55,
            decoration: BoxDecoration(
              color: ColorStyles.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: SizedBox(
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: height * 0.25,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      child: Image.asset(
                        'assets/images/감자.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const firstPostUnit(),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Container(
                      color: Colors.grey[350],
                      height: 0.5,
                      width: double.infinity,
                    ),
                  ),
                  const secondPostUnit(),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: SizedBox(
                      child: Column(
                        children: [
                          RoundedOutlinedButton(
                            text: '게시글로 이동',
                            width: double.infinity,
                            height: 35,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const DealDetailPage()));
                            },
                            foregroundColor: ColorStyles.white,
                            backgroundColor: ColorStyles.mainColor,
                            borderColor: ColorStyles.mainColor,
                            fontSize: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
