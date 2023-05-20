class Deal {
  late int dealId;
  int userId;
  String dealName;
  String dealType;
  String distance;
  String location;
  double latitude;
  double longitude;
  String dealImage;
  String dealTime;
  String dealContent;

  Deal(
      {this.dealId = 0,
      required this.userId,
      required this.dealName,
      required this.dealType,
      required this.distance,
      required this.location,
      required this.latitude,
      required this.longitude,
      required this.dealImage,
      required this.dealTime,
      required this.dealContent});

  // class to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dealId'] = dealId;
    data['userId'] = userId;
    data['dealName'] = dealName;
    data['dealSort'] = dealType;
    data['distance'] = distance;
    data['location'] = location;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['dealImage'] = dealImage;
    data['dealTime'] = dealTime;
    data['dealContent'] = dealContent;
    return data;
  }

  // class from json
  factory Deal.fromJson(Map<String, dynamic> json) {
    return Deal(
      dealId: json['dealId'],
      userId: json['userId'],
      dealName: json['dealName'],
      dealType: json['dealSort'],
      distance: json['distance'],
      location: json['location'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      dealImage: json['dealImage'],
      dealTime: json['dealTime'],
      dealContent: json['dealContent'],
    );
  }
}
