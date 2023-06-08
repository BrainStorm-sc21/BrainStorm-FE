import 'package:brainstorm_meokjang/models/chat_room.dart';
import 'package:brainstorm_meokjang/pages/chat/chat_detail_page.dart';
import 'package:brainstorm_meokjang/pages/recipe/recipe_recommend_page.dart';
import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:brainstorm_meokjang/utilities/count_hour.dart';
import 'package:brainstorm_meokjang/utilities/domain.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class GoRecipe extends StatelessWidget {
  const GoRecipe({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const RecipeRecommendPage(),
        ),
      ),
      child: Container(
        decoration: const BoxDecoration(
            color: ColorStyles.mainColor,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            )),
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
      ),
    );
  }
}

class ChatUnit extends StatefulWidget {
  final int senderId;
  final int receiverId;
  final Room room;
  final String imgUrl;
  final int unread;

  const ChatUnit({
    super.key,
    required this.senderId,
    required this.receiverId,
    required this.room,
    this.imgUrl = 'assets/images/logo.png',
    this.unread = 0,
  });

  @override
  State<ChatUnit> createState() => _ChatUnitState();
}

class _ChatUnitState extends State<ChatUnit> {
  late String nickname = '';
  String timeAgo = '';

  @override
  void initState() {
    super.initState();
    getUserNickname();
    initTimeAgo();
  }

  Future<void> getUserNickname() async {
    Dio dio = Dio();
    dio.options
      ..baseUrl = baseURI
      ..connectTimeout = const Duration(seconds: 5)
      ..receiveTimeout = const Duration(seconds: 10);

    final Response res = await dio.get('/users/${widget.receiverId}');

    try {
      if (res.data['status'] == 200) {
        Map<String, dynamic> json = res.data['data'];
        setState(() {
          nickname = json['userName'];
        });
      } else {
        setState(() {
          nickname = '(알 수 없음)';
        });
      }
    } catch (e) {
      debugPrint('$e');
    } finally {
      dio.close();
    }
  }

  void initTimeAgo() {
    DateTime? time = widget.room.lastTime;
    print(time);
    setState(() {
      timeAgo = time == null ? '' : countHour(time);
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ChatDetailPage(
            senderId: widget.senderId,
            receiverId: widget.receiverId,
            room: widget.room,
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
                              nickname,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: ColorStyles.black),
                            ),
                            Text(
                              widget.room.lastMessage!,
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
                      timeAgo,
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
