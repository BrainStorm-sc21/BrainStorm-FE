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
  String distance;
  double latitude;
  double longitude;
  String dealImage1;
  String dealImage2;
  String dealImage3;
  String dealImage4;
  String dealTime;

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
      required this.dealTime});

  // class to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dealId'] = dealId;
    data['userId'] = userId;
    data['dealType'] = dealType;
    data['dealName'] = dealName;
    data['dealContent'] = dealContent;
    data['distance'] = distance;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['dealImage1'] = dealImage1;
    data['dealImage2'] = dealImage2;
    data['dealImage3'] = dealImage3;
    data['dealImage4'] = dealImage4;
    data['dealTime'] = dealTime;
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
      dealTime: json['dealTime'],
    );
  }
}
