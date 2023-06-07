import 'package:brainstorm_meokjang/models/chat_room.dart';
import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:brainstorm_meokjang/utilities/domain.dart';
import 'package:brainstorm_meokjang/widgets/enter_chat/enter_chat_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final int userId;
  const ChatPage({
    super.key,
    required this.userId,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late List<Room> roomList = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    loadChatRoomList();
  }

  void loadChatRoomList() async {
    Dio dio = Dio();
    dio.options
      ..baseUrl = baseURI
      ..connectTimeout = const Duration(seconds: 5)
      ..receiveTimeout = const Duration(seconds: 10);

    final Response res = await dio.get('/chat/room/${widget.userId}');

    try {
      if (res.statusCode == 200) {
        print('채팅 목록 로드 성공!!:\n ${res.data}');
        setRoomList(res.data);
      }
    } catch (e) {
      debugPrint('$e');
    }
  }

  void setRoomList(Map<String, dynamic> json) {
    var list = json as List;
    setState(() {
      roomList = list.map((data) => Room.fromJson(data)).toList();
    });
    print('roomList: $roomList');
  }

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
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        width: double.infinity,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: GoRecipe(),
            ),
            ListView.builder(
              shrinkWrap: true,
              // physics: const NeverScrollableScrollPhysics(),
              itemCount: roomList.length,
              itemBuilder: (context, index) {
                return ChatUnit(
                  name: '먹짱 $index호',
                  content: '채팅 메시지 텍스트 $index',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
