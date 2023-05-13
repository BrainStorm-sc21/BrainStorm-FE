import 'package:brainstorm_meokjang/utilities/Colors.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '채팅',
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: ColorStyles.mainColor),
        ),
        backgroundColor: ColorStyles.white,
        elevation: 0,
        centerTitle: false,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          children: const [
            Padding(
              padding: EdgeInsets.all(12),
              child: GoRecipe(),
            ),
            // Positioned(
            //   bottom: 18,
            //   left: 24,
            //   right: 24,
            //   child: GestureDetector(
            //     onTap: () {
            //       print("채팅하기 클릭 됨");
            //     },
            //     child: Container(
            //       width: double.infinity,
            //       height: 58,
            //       color: Colors.green,
            //       alignment: Alignment.center,
            //       child: const Text(
            //         "chatGPT와 채팅하기",
            //         style: TextStyle(
            //           color: Colors.white,
            //           fontSize: 18,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class GoRecipe extends StatelessWidget {
  const GoRecipe({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      decoration: BoxDecoration(
        color: ColorStyles.mainColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: SizedBox(
              width: 150,
              height: 40,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Text('냉장고 속 식품 레시피',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: ColorStyles.white)),
                  Text('지금 확인하기',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: ColorStyles.white)),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
              width: 70,
              height: 50,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/images/chatGPT.png'),
              )),
            ),
          )
        ],
      ),
    );
  }
}
