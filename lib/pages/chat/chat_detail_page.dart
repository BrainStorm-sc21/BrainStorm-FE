import 'package:brainstorm_meokjang/models/message.dart';
import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:brainstorm_meokjang/widgets/rounded_outlined_button.dart';
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
  List<Message> messages = [
    Message(text: '창을 열고 세상 모든 슬픔들에게', date: DateTime.now(), isSentByMe: false),
    Message(text: '손짓을 하던 밤', date: DateTime.now(), isSentByMe: false),
    Message(text: '나의 기쁨', date: DateTime.now(), isSentByMe: false),
    Message(text: '나의 노래 되어 날아가', date: DateTime.now(), isSentByMe: true),
    Message(text: '거리를 나뒹구는', date: DateTime.now(), isSentByMe: true),
    Message(text: '쉬운 마음 되어라', date: DateTime.now(), isSentByMe: false),
  ];
  final int userId = 2; // 임시 유저 아이디

  @override
  void initState() {
    super.initState();
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

      messages.add(
        Message(text: _controller.text, date: DateTime.now(), isSentByMe: true),
      );
      debugPrint('${DateTime.now()}, ${_controller.text}');
    }
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
        child: Stack(
          children: [
            // 채팅 기록
            StreamBuilder(
              stream: _client.stream,
              builder: (context, snapshot) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return ChatBubble(
                      message: messages[index].text,
                      isSentByMe: messages[index].isSentByMe ? true : false,
                    );
                  },
                );
              },
            ),
            // 하단 바
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: ColorStyles.white,
                child: TextFieldTapRegion(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // 사진 첨부 버튼
                      IconButton(
                        onPressed: () {},
                        icon: Container(
                          width: 35,
                          height: 35,
                          decoration: const BoxDecoration(
                            color: ColorStyles.mainColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                          ),
                          child: const Icon(
                            Icons.add,
                            color: ColorStyles.white,
                          ),
                        ),
                      ),
                      // 메시지 입력 창
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          minLines: 1,
                          maxLines: 3,
                          decoration: const InputDecoration(
                            hintText: '메시지를 입력하세요',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 12.0,
                            ),
                          ),
                          onTapOutside: (event) => FocusScope.of(context).unfocus(), // 키보드 숨김,
                        ),
                      ),
                      // 전송 버튼
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: RoundedOutlinedButton(
                          text: '전송',
                          onPressed: sendMessage,
                          backgroundColor: ColorStyles.mainColor,
                          foregroundColor: ColorStyles.white,
                          borderColor: ColorStyles.mainColor,
                          radius: 5,
                        ),
                      ),
                    ],
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
        margin: const EdgeInsets.all(16.0),
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
