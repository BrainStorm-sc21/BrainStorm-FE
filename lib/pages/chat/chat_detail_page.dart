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
      body: Stack(
        children: [
          // 채팅 기록
          StreamBuilder(
            stream: _client.stream,
            builder: (context, snapshot) {
              return ChatBubble(
                message: snapshot.hasData ? '${snapshot.data}' : '',
                isByMe: false,
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
                          hintStyle: TextStyle(
                              // color: ColorStyles.textColor,
                              ),
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
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isByMe;
  const ChatBubble({
    super.key,
    required this.message,
    required this.isByMe,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: ColorStyles.lightGrey,
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
      ),
      child: Text(
        message,
        style: const TextStyle(
          color: ColorStyles.black,
        ),
      ),
    );
  }
}
