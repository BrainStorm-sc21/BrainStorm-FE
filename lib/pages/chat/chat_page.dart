import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:brainstorm_meokjang/widgets/enter_chat/enter_chat_widget.dart';
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
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(20),
              child: GoRecipe(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: const SingleChildScrollView(
                  child: Column(
                    children: [
                      ChatUnit(
                        unread: 4,
                      ),
                      ChatUnit(
                        imgUrl: 'assets/images/naver.png',
                        name: '먹짱 2호',
                        content: '네 그럼 1시에 받으러 가겠습니다👍👍',
                        time: '오전 11:46',
                        unread: 2,
                      ),
                      ChatUnit(
                        imgUrl: 'assets/images/google.png',
                        name: '먹짱 3호',
                        content: '네 수고하셔요~',
                        time: '오전 10:57',
                        unread: 0,
                      ),
                      ChatUnit(
                        imgUrl: 'assets/images/먹장로고.png',
                        name: '먹짱 4호',
                        content: '다음에 계란 사실 때 연락주세요☺️',
                        time: '어제',
                        unread: 1,
                      ),
                      ChatUnit(
                        imgUrl: 'assets/images/먹장로고.png',
                        name: '먹짱 5호',
                        content: '다음에 계란 사실 때 연락주세요☺️',
                        time: '어제',
                        unread: 1,
                      ),
                      ChatUnit(
                        imgUrl: 'assets/images/먹장로고.png',
                        name: '먹짱 6호',
                        content: '다음에 계란 사실 때 연락주세요☺️',
                        time: '어제',
                        unread: 1,
                      ),
                      ChatUnit(
                        imgUrl: 'assets/images/먹장로고.png',
                        name: '먹짱 7호',
                        content: '다음에 계란 사실 때 연락주세요☺️',
                        time: '어제',
                        unread: 1,
                      ),
                      ChatUnit(
                        imgUrl: 'assets/images/먹장로고.png',
                        name: '먹짱 8호',
                        content: '다음에 계란 사실 때 연락주세요☺️',
                        time: '어제',
                        unread: 1,
                      ),
                    ],
                  ),
                ),
              ),
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
