import 'package:brainstorm_meokjang/utilities/Colors.dart';
import 'package:brainstorm_meokjang/widgets/rounded_outlined_button.dart';
import 'package:flutter/material.dart';

class Popups {
  static void goToPost(context, type) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
              color: ColorStyles.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: SizedBox(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 25),
                      child: Text(
                        type,
                        style: const TextStyle(
                            fontSize: 24,
                            color: ColorStyles.mainColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: ColorStyles.mainColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      child: Column(
                        children: [
                          RoundedOutlinedButton(
                            text: '게시글로 이동',
                            width: double.infinity,
                            height: 35,
                            onPressed: () => Navigator.of(context).pop(),
                            foregroundColor: ColorStyles.white,
                            backgroundColor: ColorStyles.mainColor,
                            borderColor: ColorStyles.mainColor,
                            fontSize: 18,
                          ),
                          RoundedOutlinedButton(
                            text: '나가기',
                            width: double.infinity,
                            height: 35,
                            onPressed: () => Navigator.of(context).pop(),
                            foregroundColor: ColorStyles.mainColor,
                            backgroundColor: ColorStyles.white,
                            borderColor: ColorStyles.mainColor,
                            fontSize: 18,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
