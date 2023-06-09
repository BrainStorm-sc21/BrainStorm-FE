import 'package:brainstorm_meokjang/models/chat_room.dart';
import 'package:brainstorm_meokjang/models/deal.dart';
import 'package:brainstorm_meokjang/pages/chat/chat_detail_page.dart';
import 'package:brainstorm_meokjang/pages/recipe/recipe_recommend_page.dart';
import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:brainstorm_meokjang/utilities/count_hour.dart';
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
            Radius.circular(15.0),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
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
                  ),
                ),
              ),
            ),
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
  final int unread;
  final Deal deal;

  const ChatUnit({
    super.key,
    required this.senderId,
    required this.receiverId,
    required this.room,
    this.unread = 0,
    required this.deal,
  });

  @override
  State<ChatUnit> createState() => _ChatUnitState();
}

class _ChatUnitState extends State<ChatUnit> {
  String timeAgo = '';

  @override
  void initState() {
    super.initState();
    initTimeAgo();
  }

  void initTimeAgo() {
    DateTime? time = widget.room.lastTime;
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
            deal: widget.deal,
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
                        child: widget.deal.dealImage1 == null
                            ? Image.asset('assets/images/logo.png')
                            : Image.network(
                                widget.deal.dealImage1!,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.sizeOf(context).width * 0.65,
                      padding: const EdgeInsets.only(left: 10),
                      child: SizedBox(
                        height: 55,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.deal.userName!,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: ColorStyles.textColor,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              widget.room.lastMessage!,
                              maxLines: 2,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: ColorStyles.grey,
                                overflow: TextOverflow.ellipsis,
                              ),
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
                          color: ColorStyles.grey),
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
                        : const SizedBox(
                            width: 18,
                            height: 18,
                          ),
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
