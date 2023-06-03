import 'package:brainstorm_meokjang/pages/chat/chat_detail_page.dart';
import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:flutter/material.dart';

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
          const Padding(
            padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
            child: SizedBox(
              width: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
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

class ChatUnit extends StatefulWidget {
  final String imgUrl;
  final String name;
  final String content;
  final String time;
  final int unread;

  const ChatUnit({
    super.key,
    this.imgUrl = 'assets/images/logo.png',
    this.name = '먹짱 1호',
    this.content = '혹시 감자도 파시나요?',
    this.time = '오후 1:36',
    this.unread = 1,
  });

  @override
  State<ChatUnit> createState() => _ChatUnitState();
}

class _ChatUnitState extends State<ChatUnit> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ChatDetailPage(
            nickname: widget.name,
            content: widget.content,
            deal: null,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        child: SizedBox(
          width: double.infinity,
          height: 70,
          //color: ColorStyles.mainColor,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  children: [
                    SizedBox(
                      width: 55,
                      height: 55,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(widget.imgUrl),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: SizedBox(
                        height: 55,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.name,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: ColorStyles.black),
                            ),
                            Text(
                              widget.content,
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: ColorStyles.textColor),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                height: 55,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      widget.time,
                      style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: ColorStyles.textColor),
                    ),
                    widget.unread != 0
                        ? Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(9),
                              color: ColorStyles.mainColor,
                            ),
                            child: Center(
                              child: Text(
                                '${widget.unread}',
                                style: const TextStyle(
                                    fontSize: 12, color: ColorStyles.white),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
