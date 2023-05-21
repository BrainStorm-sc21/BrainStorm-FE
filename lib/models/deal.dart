class DealData {
  final List<Deal> data;

  DealData({required this.data});

  factory DealData.fromJson(Map<String, dynamic> json) {
    String imageBaseURL =
        'https://objectstorage.ap-chuncheon-1.oraclecloud.com/p/mOKCBwWiKyiyIkbN0aqY5KV5_K2-OzTt4V7feFotQqm3epdOyNO0VUJdtMUsv3Jq/n/axzkif4tbwyu/b/file-bucket/o/';
    var list = json['data'] as List;
    List<Deal> dealList = list.map((i) => Deal.fromJson(i)).toList();

    for (Deal deals in dealList) {
      if (deals.dealImage1 != Null) {
        deals.dealImage1 = '$imageBaseURL${deals.dealImage1}';
      }
      if (deals.dealImage2 != Null) {
        deals.dealImage2 = '$imageBaseURL${deals.dealImage2}';
      }
      if (deals.dealImage3 != Null) {
        deals.dealImage3 = '$imageBaseURL${deals.dealImage3}';
      }
      if (deals.dealImage4 != Null) {
        deals.dealImage4 = '$imageBaseURL${deals.dealImage4}';
      }
    }

    return DealData(data: dealList);
  }
}

class Deal {
  late int? dealId;
  int userId;
  int dealType;
  String dealName;
  String dealContent;
  double distance;
  double latitude;
  double longitude;
  String dealImage1;
  String? dealImage2;
  String? dealImage3;
  String? dealImage4;
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
    data['createdAt'] = createdAt.toString();
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
      distance: json['distance'].round(),
      latitude: json['latitude'],
      longitude: json['longitude'],
      dealImage1: json['image1'],
      dealImage2: json['image2'],
      dealImage3: json['image3'],
      dealImage4: json['image4'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
