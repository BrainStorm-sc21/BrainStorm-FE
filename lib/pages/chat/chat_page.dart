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

  Future<void> loadChatRoomList() async {
    Dio dio = Dio();
    dio.options
      ..baseUrl = baseURI
      ..connectTimeout = const Duration(seconds: 5)
      ..receiveTimeout = const Duration(seconds: 10);

    final Response res = await dio.get('/chat/room/${widget.userId}');

    try {
      if (res.data['status'] == 200) {
        print('채팅 목록 로드 성공!!:\n ${res.data['data']}');
        List<dynamic> jsonList = res.data['data'] as List;
        setState(() {
          roomList = jsonList.map((data) => Room.fromJson(data)).toList();
        });
        sortRoomListByNewest();
      } else {
        print('채팅 목록 로드 실패!!');
        throw Exception();
      }
    } catch (e) {
      debugPrint('$e');
    } finally {
      dio.close();
    }
  }

  void sortRoomListByNewest() {
    roomList.sort((b, a) {
      if (b.lastTime == null) {
        return 1;
      } else if (a.lastTime == null) {
        return 0;
      } else {
        return a.lastTime!.compareTo(b.lastTime!);
      }
    });
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
            roomList.isEmpty
                ? const Expanded(
                    child: Center(
                      child: Text('같이먹장에서 다른 사용자와 대화를 시작해보세요!'),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: roomList.length,
                      itemBuilder: (context, index) {
                        return ChatUnit(
                          senderId: widget.userId,
                          receiverId: roomList[index].sender == widget.userId
                              ? roomList[index].receiver
                              : roomList[index].sender,
                          room: roomList[index],
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
