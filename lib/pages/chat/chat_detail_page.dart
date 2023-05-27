import 'package:brainstorm_meokjang/models/chat_message.dart';
import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatDetailPage extends StatefulWidget {
  final String nickname;
  final String content;
  const ChatDetailPage({
    super.key,
    required this.nickname,
    required this.content,
  });

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final TextEditingController _controller = TextEditingController();
  // final WebSocketChannel _client = IOWebSocketChannel.connect('ws://meokjang.com/chat');
  final WebSocketChannel _client = IOWebSocketChannel.connect(
    Uri.parse('wss://echo.websocket.events'),
  );
  final int userId = 2; // 임시 유저 아이디
  List<Message> messages = [
    Message(
      type: "TALK",
      sender: 1,
      message: '창을 열고 세상 모든 슬픔들에게',
      date: DateTime.now(),
    ),
    Message(
      type: "TALK",
      sender: 1,
      message: '손짓을 하던 밤',
      date: DateTime.now(),
    ),
    Message(
      type: "TALK",
      sender: 1,
      message: '나의 기쁨',
      date: DateTime.now(),
    ),
    Message(
      type: "TALK",
      sender: 2,
      message: '나의 노래 되어 날아가',
      date: DateTime.now(),
    ),
    Message(
      type: "TALK",
      sender: 2,
      message: '거리를 나뒹구는',
      date: DateTime.now(),
    ),
    Message(
      type: "TALK",
      sender: 1,
      message: '쉬운 마음 되어라',
      date: DateTime.now(),
    ),
  ];

  @override
  void initState() {
    super.initState();
    listen();
  }

  @override
  void dispose() {
    _client.sink.close();
    _controller.dispose();
    super.dispose();
  }

  void sendMessage() {
    if (_controller.text.trim().isNotEmpty) {
      _client.sink.add(_controller.text);
      _controller.clear();
    }
  }

  void listen() {
    _client.stream.listen((message) {
      // 상대방에게 받은 message를 가공해서 list에 추가
      debugPrint('$message');
      setState(() {
        messages.add(message);
      });
    });
  }

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
                Text(
                  widget.nickname,
                  style: const TextStyle(
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
      body: Container(
        color: ColorStyles.white,
        child: Column(
          children: [
            // 채팅 기록
            Expanded(
              child: StreamBuilder(
                stream: _client.stream,
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    messages.add(
                      Message(
                        type: "TALK",
                        sender: userId,
                        message: snapshot.data,
                        date: DateTime.now(),
                      ),
                    );
                    debugPrint('${DateTime.now()}, ${snapshot.data}');
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return ChatBubble(
                        message: messages[index].message,
                        isSentByMe: messages[index].sender == userId ? true : false,
                      );
                    },
                  );
                },
              ),
            ),
            // 하단 바
            Container(
              color: ColorStyles.white,
              child: TextFieldTapRegion(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 메시지 입력 창
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: ColorStyles.lightGrey,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(25.0),
                          ),
                        ),
                        child: TextField(
                          controller: _controller,
                          minLines: 1,
                          maxLines: 3,
                          decoration: const InputDecoration(
                            hintText: '메시지를 입력하세요',
                            hintStyle: TextStyle(
                              color: ColorStyles.iconColor,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 4.0,
                              horizontal: 18.0,
                            ),
                          ),
                          onTapOutside: (event) => FocusScope.of(context).unfocus(), // 키보드 숨김,
                        ),
                      ),
                    ),
                    // 전송 버튼
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: InkWell(
                        onTap: sendMessage,
                        child: const Icon(
                          Icons.send_rounded,
                          color: ColorStyles.mainColor,
                          size: 35,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isSentByMe;
  const ChatBubble({
    super.key,
    required this.message,
    required this.isSentByMe,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSentByMe ? Alignment.topRight : Alignment.topLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: isSentByMe ? ColorStyles.groupBuyColor : ColorStyles.lightGrey,
          borderRadius: isSentByMe
              ? const BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                  bottomLeft: Radius.circular(16.0),
                  bottomRight: Radius.zero,
                )
              : const BorderRadius.only(
                  topLeft: Radius.zero,
                  topRight: Radius.circular(16.0),
                  bottomLeft: Radius.circular(16.0),
                  bottomRight: Radius.circular(16.0),
                ),
        ),
        child: Text(
          message,
          style: TextStyle(
            color: isSentByMe ? ColorStyles.chatTextColor : ColorStyles.textColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
