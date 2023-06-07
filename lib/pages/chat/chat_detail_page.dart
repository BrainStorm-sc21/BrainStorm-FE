import 'dart:convert';
import 'dart:io';
import 'package:brainstorm_meokjang/models/chat_message.dart';
import 'package:brainstorm_meokjang/models/deal.dart';
import 'package:brainstorm_meokjang/pages/deal/trading_board_page.dart';
import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:brainstorm_meokjang/utilities/domain.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatDetailPage extends StatefulWidget {
  final String nickname;
  final String content;
  final Deal? deal;
  const ChatDetailPage({
    super.key,
    required this.nickname,
    required this.content,
    required this.deal,
  });

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final TextEditingController _controller = TextEditingController();
  final WebSocketChannel _client =
      IOWebSocketChannel.connect('ws://meokjang.com/chat');
  // final WebSocketChannel _client = IOWebSocketChannel.connect(
  //   Uri.parse('wss://echo.websocket.events'),
  // );
  final int userId = 7; // 임시 유저 아이디
  List<Message> messages = List.empty(growable: true);
  late final File historyFile;
  late final String _roomId;

  @override
  void initState() {
    super.initState();
    _initializeFile();
  }

  @override
  void dispose() {
    _client.sink.close();
    _controller.dispose();
    super.dispose();
  }

  bool get isTextInputEmpty {
    return _controller.text.trim().isEmpty;
  }

  void sendMessage(MessageType type, String message) {
    Message data = Message(
      type: type,
      roomId: _roomId,
      sender: userId,
      message: message,
    );
    _client.sink.add(jsonEncode(data));
    _controller.clear();
  }

  Future<String> get _directoryPath async {
    final Directory directory = await getApplicationDocumentsDirectory();
    print("디렉토리 경로: ${directory.path}");
    return directory.path;
  }

  Future<File> get _chatHistoryFile async {
    final String path = await _directoryPath;
    var fileName = 'TEMP';
    return File('$path/$fileName.json');
  }

  void _initializeFile() async {
    historyFile = await _chatHistoryFile;
    if (historyFile.existsSync()) {
      _readJson();
    } else {
      _createChatRoom();
    }
  }

  void _createChatRoom() async {
    Dio dio = Dio();
    dio.options
      ..baseUrl = baseURI
      ..connectTimeout = const Duration(seconds: 5)
      ..receiveTimeout = const Duration(seconds: 10);

    String roomName = 'RoomTest'; // 임시 roomName
    try {
      final res = await dio.post(
        '/chat?name=$roomName',
      );

      debugPrint('req data: ${res.data}');
      debugPrint('req statusCode: ${res.statusCode}');

      if (res.statusCode == 200) {
        setState(() {
          _roomId = res.data['roomId'];
        });
        sendMessage(MessageType.ENTER, "");
      } else {
        throw Exception('Failed to create chat room [${res.statusCode}]');
      }
    } catch (err) {
      debugPrint('$err');
    } finally {
      dio.close();
    }
  }

  void _writeJson() async {
    final List<String> jsonStringList =
        messages.map((message) => jsonEncode(message)).toList();
    final String jsonString = '[${jsonStringList.join(',\n')}]';
    await historyFile.writeAsString(jsonString);
  }

  void _readJson() async {
    String jsonString = await historyFile.readAsString();
    List<dynamic> jsonList = jsonDecode(jsonString);
    for (Map<String, dynamic> jsonMessage in jsonList) {
      Message message = Message.fromJson(jsonMessage);
      messages.add(message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: ColorStyles.white,
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
                const Text(
                  '삼식이 네끼',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: ColorStyles.black,
                  ),
                ),
                // TextButton(
                //   onPressed: _writeJson,
                //   child: const Text('파일 쓰기 버튼'),
                // ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        color: ColorStyles.white,
        child: Column(
          children: [
            (widget.deal != null)
                ? Container(
                    height: 80,
                    color: ColorStyles.white,
                    child: OnePostUnit(
                      deal: widget.deal!,
                      isChat: true,
                    ),
                  )
                : Container(
                    height: 80,
                  ),
            // 채팅 기록
            Expanded(
              // child: Center(
              //     child: Text(
              //   '삼식이 네끼님과\n채팅을 시작해보세요!',
              //   style: TextStyle(
              //       color: ColorStyles.mainColor,
              //       fontSize: 16,
              //       fontWeight: FontWeight.w400),
              //   textAlign: TextAlign.center,
              // )),
              child: StreamBuilder(
                stream: _client.stream,
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    debugPrint('snpashot.data: ${snapshot.data}');
                    Map<String, dynamic> jsonData = jsonDecode(snapshot.data);
                    messages.add(Message.fromJson(jsonData));
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return ChatBubble(
                        type: messages[index].type,
                        message: messages[index].message,
                        isSentByMe:
                            messages[index].sender == userId ? true : false,
                      );
                    },
                  );
                },
              ),
            ),
            // 하단 바
            Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
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
                            onTapOutside: (event) =>
                                FocusScope.of(context).unfocus(), // 키보드 숨김,
                          ),
                        ),
                      ),
                      // 전송 버튼
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: InkWell(
                          onTap: () {
                            if (isTextInputEmpty == false) {
                              sendMessage(MessageType.TALK, _controller.text);
                            }
                          },
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
            ),
          ],
        ),
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final MessageType type;
  final String message;
  final bool isSentByMe;
  const ChatBubble({
    super.key,
    required this.type,
    required this.message,
    required this.isSentByMe,
  });

  @override
  Widget build(BuildContext context) {
    return type == MessageType.TALK
        ? Align(
            alignment: isSentByMe ? Alignment.topRight : Alignment.topLeft,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              margin:
                  const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
              decoration: BoxDecoration(
                color: isSentByMe
                    ? ColorStyles.groupBuyColor
                    : ColorStyles.lightGrey,
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
                  color: isSentByMe
                      ? ColorStyles.chatTextColor
                      : ColorStyles.textColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          )
        : Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              margin:
                  const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
              child: Text(
                message,
                style: const TextStyle(
                  color: ColorStyles.textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
  }
}
