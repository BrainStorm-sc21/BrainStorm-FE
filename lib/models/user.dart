import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert' as convert;

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

  User(
      {required this.userName,
      required this.location,
      required this.latitude,
      required this.longitude,
      required this.gender});

  // factory User.fromJson(Map<String, dynamic> json) {
  //   return User(
  //     userName: json["userName"],
  //     location: json["location"],

  //   );
  // }
}

// class Position {
//   String address;
//   double? latitude;
//   double? longitude;

//   Position(this.address, this.latitude, this.longitude);
// }

Future<String> postSignUp(User user) async {
  print('통신 시작');
  final uri = Uri.https('www.meokjang.com', '/users');
  var response = await http.post(
    uri,
    body: convert.jsonEncode({
      "userName": user.userName,
      "phoneNumber": user.phoneNumber,
      "snsType": user.snsType,
      "snsKey": user.snsKey,
      "location": user.location,
      "latitude": user.latitude,
      "longitude": user.longitude,
      "gender": user.gender,
    }),
  );

  var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
  var responseStatus = jsonResponse['status'];

  print('통신 끝');

  return response.body;
}
