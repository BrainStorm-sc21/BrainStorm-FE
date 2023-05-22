import 'package:brainstorm_meokjang/utilities/domain.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  late int? userId;
  String userName;
  String? phoneNumber;
  String? snsType;
  String? snsKey;
  String location;
  double latitude;
  double longitude;
  int? gender;
  double? reliability;
  DateTime? stopUntil;
  DateTime? createdAt;

  User({
    this.userId,
    required this.userName,
    this.phoneNumber,
    this.snsType,
    this.snsKey,
    required this.location,
    required this.latitude,
    required this.longitude,
    this.gender,
    this.reliability,
    this.stopUntil,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['userName'] = userName;
    data['phoneNumber'] = phoneNumber;
    data['snsType'] = snsType;
    data['snsKey'] = snsKey;
    data['location'] = location;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['gender'] = gender;

    return data;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['data']['userId'],
      userName: json['data']['userName'],
      location: json['data']['location'],
      longitude: json['data']['longitude'],
      latitude: json['data']['latitude'],
      reliability: json['data']['reliability'],
      stopUntil: json['data']['stopUntil'],
    );
  }
}

void requestSignUp(User user) async {
  const storage = FlutterSecureStorage();
  dynamic userId;
  Dio dio = Dio();
  dio.options
    ..baseUrl = baseURI
    ..connectTimeout = const Duration(seconds: 15)
    ..receiveTimeout = const Duration(seconds: 15);

  final data = user.toJson();
  debugPrint('req data: $data');

  try {
    final res = await dio.post(
      '/users/create',
      data: data,
    );

    if (res.data['status'] == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt('userId', res.data['data']['userId']);
      prefs.setBool('isUser', true);
    } else if (res.data['status'] == 400) {
      print('회원가입 실패!!');
      throw Exception('Failed to send data [${res.statusCode}]');
    }
  } catch (err) {
    debugPrint('$err');
  } finally {
    dio.close();
  }
  return null;
}
