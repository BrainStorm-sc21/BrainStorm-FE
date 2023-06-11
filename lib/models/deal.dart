class DealData {
  final List<Deal> data;

  DealData({required this.data});

  factory DealData.fromJson(Map<String, dynamic> json) {
    //String imageBaseURL =
    //'https://objectstorage.ap-chuncheon-1.oraclecloud.com/p/mOKCBwWiKyiyIkbN0aqY5KV5_K2-OzTt4V7feFotQqm3epdOyNO0VUJdtMUsv3Jq/n/axzkif4tbwyu/b/file-bucket/o/';
    var list = json['data'] as List;

    List<Deal> dealList = list.map((i) => Deal.fromJson(i)).toList();

    // for (Deal deals in dealList) {
    //   print(deals.dealName);
    //   if (deals.dealImage1 != null) {
    //     deals.dealImage1 = '$imageBaseURL${deals.dealImage1}.jpg';
    //   }
    //   if (deals.dealImage2 != null) {
    //     deals.dealImage2 = '$imageBaseURL${deals.dealImage2}.jpg';
    //   }
    //   if (deals.dealImage3 != null) {
    //     deals.dealImage3 = '$imageBaseURL${deals.dealImage3}.jpg';
    //   }
    //   if (deals.dealImage4 != null) {
    //     deals.dealImage4 = '$imageBaseURL${deals.dealImage4}.jpg';
    //   }
    // }

    return DealData(data: dealList);
  }
}

class Deal {
  int? dealId;
  int userId;
  String? userName;
  double? reliability;
  int dealType;
  String dealName;
  String dealContent;
  double? distance;
  double latitude;
  double longitude;
  String? dealImage1;
  String? dealImage2;
  String? dealImage3;
  String? dealImage4;
  bool? isClosed;
  DateTime createdAt;

  Deal(
      {this.dealId = 0,
      required this.userId,
      this.userName,
      this.reliability,
      required this.dealType,
      required this.dealName,
      required this.dealContent,
      required this.distance,
      required this.latitude,
      required this.longitude,
      this.dealImage1,
      this.dealImage2,
      this.dealImage3,
      this.dealImage4,
      this.isClosed,
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
    // data['dealImage1'] = dealImage1;
    // data['dealImage2'] = dealImage2;
    // data['dealImage3'] = dealImage3;
    // data['dealImage4'] = dealImage4;
    //data['createdAt'] = createdAt;
    return data;
  }

  // class from json
  factory Deal.fromJson(Map<String, dynamic> json) {
    String imageBaseURL =
        'https://objectstorage.ap-chuncheon-1.oraclecloud.com/p/mOKCBwWiKyiyIkbN0aqY5KV5_K2-OzTt4V7feFotQqm3epdOyNO0VUJdtMUsv3Jq/n/axzkif4tbwyu/b/file-bucket/o/';

    return Deal(
      dealId: json['dealId'],
      userId: json['userId'],
      userName: json['userName'] ?? '(알 수 없음)',
      reliability: json['reliability'] ?? 0.0,
      dealType: json['dealType'],
      dealName: json['dealName'],
      dealContent: json['dealContent'],
      distance: json['distance'] ?? 0.0,
      latitude: json['latitude'],
      longitude: json['longitude'],
      dealImage1: json['image1'] != null ? imageBaseURL + json['image1'] : null,
      dealImage2: json['image2'] != null ? imageBaseURL + json['image2'] : null,
      dealImage3: json['image3'] != null ? imageBaseURL + json['image3'] : null,
      dealImage4: json['image4'] != null ? imageBaseURL + json['image4'] : null,
      isClosed: json['isClosed'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
