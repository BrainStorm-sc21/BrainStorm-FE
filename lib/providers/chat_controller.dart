import 'package:brainstorm_meokjang/models/chat_room.dart';
import 'package:brainstorm_meokjang/utilities/domain.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  RxList<Room> roomList = <Room>[].obs;

  // load chat room list from DB
  Future<void> loadChatRoomList(int userId) async {
    Dio dio = Dio();
    dio.options
      ..baseUrl = baseURI
      ..connectTimeout = const Duration(seconds: 5)
      ..receiveTimeout = const Duration(seconds: 10);

    final res = await dio.get('/chat/room/$userId');

    try {
      if (res.data['status'] == 200) {
        print('채팅 목록 로드 성공!!:\n ${res.data['data']}');
        List<dynamic> jsonList = res.data['data'] as List;
        roomList.value = jsonList.map((data) => Room.fromJson(data)).toList();
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

  // sort chat rooms by newest message
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
}
