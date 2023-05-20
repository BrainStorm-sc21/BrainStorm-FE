import 'package:brainstorm_meokjang/utilities/domain.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DealData {
  final List<Deal> data;

  DealData({required this.data});

  factory DealData.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<Deal> dealList = list.map((i) => Deal.fromJson(i)).toList();

    return DealData(data: dealList);
  }
}

class Deal {
  late int dealId;
  int userId;
  int dealType;
  String dealName;
  String dealContent;
  int distance;
  double latitude;
  double longitude;
  String dealImage1;
  String dealImage2;
  String dealImage3;
  String dealImage4;
  DateTime createdAt;

  Deal(
      {this.dealId = 0,
      required this.userId,
      required this.dealType,
      required this.dealName,
      required this.dealContent,
      required this.distance,
      required this.latitude,
      required this.longitude,
      this.dealImage1 = '',
      this.dealImage2 = '',
      this.dealImage3 = '',
      this.dealImage4 = '',
      required this.createdAt});

  // class to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    //data['dealId'] = dealId;
    data['userId'] = userId;
    data['dealType'] = dealType;
    data['dealName'] = dealName;
    data['dealContent'] = dealContent;
    //data['distance'] = distance;
    //data['latitude'] = latitude;
    //data['longitude'] = longitude;
    data['dealImage1'] = dealImage1;
    data['dealImage2'] = dealImage2;
    data['dealImage3'] = dealImage3;
    data['dealImage4'] = dealImage4;
    //data['createdAt'] = createdAt;
    return data;
  }

  // class from json
  factory Deal.fromJson(Map<String, dynamic> json) {
    return Deal(
      dealId: json['dealId'],
      userId: json['userId'],
      dealType: json['dealType'],
      dealName: json['dealName'],
      dealContent: json['dealContent'],
      distance: json['distance'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      dealImage1: json['dealImage1'],
      dealImage2: json['dealImage2'],
      dealImage3: json['dealImage3'],
      dealImage4: json['dealImage4'],
      createdAt: json['createdAt'],
    );
  }
}

Future<int?> requestRegisterPost(Deal deal) async {
  Dio dio = Dio();
  dio.options
    ..baseUrl = baseURI
    ..connectTimeout = const Duration(seconds: 5)
    ..receiveTimeout = const Duration(seconds: 10);

  final data = deal.toJson();
  debugPrint('req data: $data');

  try {
    final res = await dio.post(
      '/deal',
      data: data,
    );

    if (res.statusCode == 200) {
      print("게시글 등록 성공!!");
    } else {
      throw Exception('Failed to send data [${res.statusCode}]');
    }
  } on DioError {
    // Popups.popSimpleDialog(
    //   context,
    //   title: '${err.type}',
    //   body: '${err.message}',
    // );
  } catch (err) {
    debugPrint('$err');
  } finally {
    dio.close();
  }
  return null;
}
