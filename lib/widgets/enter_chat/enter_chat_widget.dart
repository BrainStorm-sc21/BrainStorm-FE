import 'package:brainstorm_meokjang/models/chat_room.dart';
import 'package:brainstorm_meokjang/models/deal.dart';
import 'package:brainstorm_meokjang/pages/chat/chat_detail_page.dart';
import 'package:brainstorm_meokjang/pages/recipe/snapping_sheet.dart';
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
          builder: (context) => const RecipeSnappingSheet(),
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
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
              child: SizedBox(
                width: 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Text('냉장고 속 식품 레시피',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600, color: ColorStyles.white)),
                    Text('지금 확인하기',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w400, color: ColorStyles.white)),
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
  final int fromId;
  final int toId;
  final Room room;
  final int unread;
  final Deal deal;

  const ChatUnit({
    super.key,
    required this.fromId,
    required this.toId,
    required this.room,
    this.unread = 0,
    required this.deal,
  });

  @override
  State<ChatUnit> createState() => _ChatUnitState();
}

class _ChatUnitState extends State<ChatUnit> {
  String timeAgo = '';
  late String receiverName = '(알 수 없음)';

  @override
  void initState() {
    super.initState();
    getReceiverName();
    initTimeAgo();
  }

  void initTimeAgo() {
    DateTime? time = widget.room.lastTime;
    setState(() {
      timeAgo = time == null ? '' : countHour(time);
    });
  }

  // 상대방 닉네임 가져오기
  Future<void> getReceiverName() async {
    Dio dio = Dio();
    dio.options
      ..baseUrl = baseURI
      ..connectTimeout = const Duration(seconds: 5)
      ..receiveTimeout = const Duration(seconds: 10);

    final Response res = await dio.get('/users/${widget.toId}');

    try {
      if (res.data['status'] == 200) {
        Map<String, dynamic> json = res.data['data'];
        setState(() {
          receiverName = json['userName'];
        });
      } else {
        setState(() {
          receiverName = '(알 수 없음)';
        });
      }
    } catch (e) {
      debugPrint('$e');
    } finally {
      dio.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ChatDetailPage(
            senderId: widget.fromId,
            receiverId: widget.toId,
            receiverName: receiverName,
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
                    width: MediaQuery.of(context).size.width * 0.65,
                    padding: const EdgeInsets.only(left: 10),
                    child: SizedBox(
                      height: 55,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            receiverName,
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
                          fontSize: 11, fontWeight: FontWeight.w400, color: ColorStyles.grey),
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
                                style: const TextStyle(fontSize: 12, color: ColorStyles.white),
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
