import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:brainstorm_meokjang/widgets/rounded_outlined_button.dart';
import 'package:flutter/material.dart';

class ChatDetailPage extends StatelessWidget {
  const ChatDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: ColorStyles.black,
        flexibleSpace: SafeArea(
          child: Container(
            height: 60,
            color: ColorStyles.white,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  onPressed: () => Navigator.of(context).pop(),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                ),
                const Text(
                  '닉네임',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: ColorStyles.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: ColorStyles.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 사진 첨부 버튼
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    icon: Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                        color: ColorStyles.mainColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: ColorStyles.white,
                      ),
                    ),
                  ),
                  // 메시지 입력 창

                  // 전송 버튼
                  RoundedOutlinedButton(
                    text: '전송',
                    onPressed: () {},
                    backgroundColor: ColorStyles.mainColor,
                    foregroundColor: ColorStyles.white,
                    borderColor: ColorStyles.mainColor,
                    radius: 5,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
