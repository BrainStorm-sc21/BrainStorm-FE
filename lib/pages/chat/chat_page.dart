import 'package:brainstorm_meokjang/providers/chat_controller.dart';
import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:brainstorm_meokjang/widgets/enter_chat/enter_chat_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  late final ChatController _chatController = Get.put(ChatController());

  @override
  void initState() {
    super.initState();
    _chatController.loadChatRoomList(widget.userId);
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
            _chatController.roomList.isEmpty
                ? const Expanded(
                    child: Center(
                      child: Text('같이먹장에서 다른 사용자와 대화를 시작해보세요!'),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: _chatController.roomList.length,
                      itemBuilder: (context, index) {
                        return ChatUnit(
                          senderId: widget.userId,
                          receiverId: _chatController.roomList[index].sender ==
                                  widget.userId
                              ? _chatController.roomList[index].receiver
                              : _chatController.roomList[index].sender,
                          room: _chatController.roomList[index],
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
