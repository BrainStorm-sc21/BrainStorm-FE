import 'package:brainstorm_meokjang/models/location.dart';

class Deal {
  late int dealId;
  String dealName;
  String dealType;
  String distance;
  LocationClass location;
  String dealImage;
  String dealTime;

  Deal(
      {this.dealId = 0,
      required this.dealName,
      required this.dealType,
      required this.distance,
      required this.location,
      required this.dealImage,
      required this.dealTime});

  // class to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dealId'] = dealId;
    data['dealName'] = dealName;
    data['dealSort'] = dealType;
    data['distance'] = distance;
    data['location'] = location;
    data['dealImage'] = dealImage;
    data['dealTime'] = dealTime;
    return data;
  }

  // class from json
  factory Deal.fromJson(Map<String, dynamic> json) {
    return Deal(
      dealId: json['dealId'],
      dealName: json['dealName'],
      dealType: json['dealSort'],
      distance: json['distance'],
      location: json['location'],
      dealImage: json['dealImage'],
      dealTime: json['dealTime'],
    );
  }
}
