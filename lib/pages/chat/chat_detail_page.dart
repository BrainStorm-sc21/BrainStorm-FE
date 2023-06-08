import 'dart:convert';
import 'package:brainstorm_meokjang/models/chat_message.dart';
import 'package:brainstorm_meokjang/models/chat_room.dart';
import 'package:brainstorm_meokjang/models/deal.dart';
import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:brainstorm_meokjang/utilities/domain.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatDetailPage extends StatefulWidget {
  final int receiverId;
  final int senderId;
  final Room? room;
  final Deal? deal;
  const ChatDetailPage({
    super.key,
    required this.receiverId,
    required this.deal,
    required this.senderId,
    this.room,
  });

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final TextEditingController _controller = TextEditingController();
  final WebSocketChannel _client =
      IOWebSocketChannel.connect('ws://www.meokjang.com/ws/chat');

  late String nickname = '';

  bool isRoomExist = false;
  late int dbRoomId;
  late String wsRoomId;

  List<Message> messages = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    getUserNickname();
    if (widget.room != null) {
      setIsRoomExistToTrue();
      setRoomIds(widget.room!.id, widget.room!.roomId);
      sendMessage(MessageType.ENTER, '');
      loadPrevMessages();
    }
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

  void setIsRoomExistToTrue() {
    setState(() => isRoomExist = true);
  }

  Future<void> setRoomIds(int id, String roomId) async {
    setState(() {
      dbRoomId = id;
      wsRoomId = roomId;
    });
  }

  Future<void> createChatRoom() async {
    Dio dio = Dio();
    dio.options
      ..baseUrl = baseURI
      ..connectTimeout = const Duration(seconds: 5)
      ..receiveTimeout = const Duration(seconds: 10);

    final data = {
      "sender": widget.senderId,
      "receiver": widget.receiverId,
    };

    try {
      final Response res = await dio.post(
        '/chat',
        data: data,
      );

      if (res.data['status'] == 200) {
        debugPrint('채팅방 생성 성공!!:\n ${res.data['data']}');
        Room room = Room.fromJson(res.data['data']);
        setRoomIds(room.id, room.roomId);
        setIsRoomExistToTrue();
      } else {
        throw Exception();
      }
    } catch (e) {
      debugPrint('$e');
    } finally {
      dio.close();
    }
  }

  void checkRoomExist(MessageType type, String message) async {
    if (isRoomExist == false) {
      await createChatRoom();
      sendMessage(MessageType.ENTER, '');
      sendMessage(type, message);
    } else {
      sendMessage(type, message);
    }
  }

  void sendMessage(MessageType type, String message) {
    DateTime time = DateTime.now();
    String timeFormatted = DateFormat("yyyy-MM-ddTHH:mm:ss").format(time);
    Message data = Message(
      type: type,
      roomId: wsRoomId,
      sender: widget.senderId,
      message: message,
      time: timeFormatted,
    );
    print(jsonEncode(data));
    _client.sink.add(jsonEncode(data));
    _controller.clear();
  }

  Future<void> loadPrevMessages() async {
    Dio dio = Dio();
    dio.options
      ..baseUrl = baseURI
      ..connectTimeout = const Duration(seconds: 5)
      ..receiveTimeout = const Duration(seconds: 10);

    try {
      final Response res = await dio.get(
        '/chat/message/$dbRoomId',
      );

      if (res.data['status'] == 200) {
        debugPrint('메시지 로드 성공!!');
        List<dynamic> jsonList = res.data['data'] as List;
        setState(() {
          messages = jsonList.map((data) => Message.fromJson(data)).toList();
        });
      } else {
        throw Exception();
      }
    } catch (e) {
      debugPrint('$e');
    } finally {
      dio.close();
    }
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
                Text(
                  nickname,
                  style: const TextStyle(
                    fontSize: 20,
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
            /*
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
                  */
            // 채팅 기록
            Expanded(
              child: StreamBuilder(
                stream: _client.stream,
                builder: (context, snapshot) {
                  debugPrint('snapshot.data: ${snapshot.data}');
                  if (snapshot.data != null) {
                    Map<String, dynamic> jsonData = jsonDecode(snapshot.data);
                    messages.add(Message.fromJson(jsonData));
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return ChatBubble(
                        message: messages[index].message,
                        isSentByMe: messages[index].sender == widget.senderId
                            ? true
                            : false,
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
                            debugPrint('메시지 전송 버튼 눌림!!');
                            if (isTextInputEmpty == false) {
                              checkRoomExist(
                                  MessageType.TALK, _controller.text);
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
            color:
                isSentByMe ? ColorStyles.chatTextColor : ColorStyles.textColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
