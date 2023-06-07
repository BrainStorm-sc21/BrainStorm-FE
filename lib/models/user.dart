import 'package:brainstorm_meokjang/app_pages_container.dart';
import 'package:brainstorm_meokjang/pages/start/onboarding_page.dart';
import 'package:brainstorm_meokjang/utilities/domain.dart';
import 'package:brainstorm_meokjang/utilities/toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
  String? stopUntil;
  String? createdAt;

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

  Map<String, dynamic> toJsonForSignUp() {
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

  Map<String, dynamic> toJsonForLogin() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (phoneNumber != null) {
      data['phoneNumber'] = phoneNumber;
    }

    if (snsType != null) {
      data['snsType'] = snsType;
      data['snsKey'] = snsKey;
    }

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

Map<String, String> toJsonPhoneNumber(String phoneNumber) {
  final Map<String, String> data = <String, String>{};

  data['phoneNumber'] = phoneNumber;

  return data;
}

Map<String, String> toJsonSNS(String snsType, String snsKey) {
  final Map<String, String> data = <String, String>{};

  data['snsType'] = snsType;
  data['snsKey'] = snsKey;

  return data;
}

Future<int> requestSignUp(User user) async {
  Dio dio = Dio();
  dio.options
    ..baseUrl = baseURI
    ..connectTimeout = const Duration(seconds: 10)
    ..receiveTimeout = const Duration(seconds: 15);

  final data = user.toJsonForSignUp();
  debugPrint('req data: $data');

  try {
    final res = await dio.post(
      '/users/create',
      data: data,
    );

    if (res.data['status'] == 200) {
      print('회원가입 성공!!');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print("유저아이디: ${res.data['data']['userId']}");
      prefs.setInt('userId', res.data['data']['userId']);
      prefs.setBool('isMeokjangUser', true);
      setUserInfo(user);
      return res.data['data']['userId'];
    } else if (res.data['status'] == 400) {
      print('회원가입 실패!!');
      return -1;
    }
  } catch (err) {
    debugPrint('$err');
  } finally {
    dio.close();
  }
  return -1;
}

void requestLogin(String? phoneNumber, String? snsType, String? snsKey,
    BuildContext context) async {
  Dio dio = Dio();
  dio.options
    ..baseUrl = baseURI
    ..connectTimeout = const Duration(seconds: 20)
    ..receiveTimeout = const Duration(seconds: 20);

  final Map<String, String>? data;

  if (phoneNumber != null) {
    data = toJsonPhoneNumber(phoneNumber);
  } else if (snsType != null && snsKey != null) {
    data = toJsonSNS(snsType, snsKey);
  } else {
    data = null;
  }

  debugPrint('req data: $data');

  try {
    final res = await dio.post(
      '/users/login',
      data: data,
    );

    if (res.data['status'] == 200) {
      print('로그인 성공!!');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt('userId', res.data['data']['userId']);
      prefs.setBool('isMeokjangUser', true);
      //setUserInfo(user);
      showToast('로그인 되었습니다');
      if (!context.mounted) return;

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  AppPagesContainer(userId: res.data['data']['userId'])),
          (route) => false);
      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AppPagesContainer(userId: res.data['data']['userId'])),);
    } else if (res.data['status'] == 401) {
      print('로그인 실패!!');
      showToast('로그인에 실패했습니다. 다시 시도해주세요');
      throw Exception('Failed to send data [${res.statusCode}]');
    }
  } catch (err) {
    debugPrint('$err');
  } finally {
    dio.close();
  }
  return null;
}

Future<int> requestLogout(context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  prefs.remove('isMeokjangUser');
  prefs.remove('userId');

  showToast('로그아웃 되었습니다');

  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const OnboardingPage()),
      (route) => false);

  return 0;
}

void setUserInfo(User user) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  prefs.setString('userName', user.userName);
  prefs.setString('location', user.location);
  prefs.setDouble('latitude', user.latitude);
  prefs.setDouble('longitude', user.longitude);
  prefs.setDouble('reliability', user.reliability!);
  prefs.setString('stopUntil', user.stopUntil!);
}
