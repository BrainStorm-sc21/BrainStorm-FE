import 'package:brainstorm_meokjang/pages/start/signup_page.dart';

class User {
  //int userId;
  String userName;
  String? phoneNumber;
  String? snsType;
  String? snsKey;
  String location;
  double? latitude;
  double? longitude;
  int gender;
  //Float reliability;
  // DateTime? stopUntil;
  // DateTime createdAt;

  User({
    required this.userName,
    required this.phoneNumber,
    required this.snsType,
    required this.snsKey,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.gender,
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

  // factory User.fromJson(Map<String, dynamic> json) {
  //   return User(
  //     userName: json["userName"],
  //     location: json["location"],
  //   );
  // }
}

Future<int?> postSignUp(User user) async {
  return null;
}
