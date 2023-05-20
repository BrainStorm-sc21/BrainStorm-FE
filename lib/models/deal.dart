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
  late int? dealId;
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
    data['dealId'] = dealId;
    data['userId'] = userId;
    data['dealType'] = dealType;
    data['dealName'] = dealName;
    data['dealContent'] = dealContent;
    data['distance'] = distance;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['image1'] = dealImage1;
    data['image2'] = dealImage2;
    data['image3'] = dealImage3;
    data['image4'] = dealImage4;
    data['createdAt'] = createdAt;
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
      dealImage1: json['image1'],
      dealImage2: json['image2'],
      dealImage3: json['image3'],
      dealImage4: json['image4'],
      createdAt: json['createdAt'],
    );
  }
}
