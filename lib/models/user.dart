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
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.gender,
  });

  // factory User.fromJson(Map<String, dynamic> json) {
  //   return User(
  //     userName: json["userName"],
  //     location: json["location"],

  //   );
  // }
}

// Future<int?> postSignUp(User user) async {
//   print('통신 시작');
//   Dio dio = Dio();

//   dio.options.baseUrl = 'www.meokjang.com';

//   //final response = await dio.post('\users', data: {});

//   // response = await dio.post(
//   //   'www.meokjang.com/users',
//   //   queryParameters: {
//   //     "userName": '먹짱2호',
//   //     "phoneNumber": '010-1234-1234',
//   //     "snsType": null,
//   //     "snsKey": null,
//   //     "location": '서울 강남구 강남대로',
//   //     "latitude": user.latitude,
//   //     "longitude": user.longitude,
//   //     "gender": user.gender,
//   //   },
//   // );

//   // final uri = Uri.https('', '/users');
//   // var response = await http.post(
//   //   uri,
//   //   body: convert.jsonEncode({
//   //     "userName": user.userName,
//   //     "phoneNumber": user.phoneNumber,
//   //     "snsType": user.snsType,
//   //     "snsKey": user.snsKey,
//   //     "location": user.location,
//   //     "latitude": user.latitude,
//   //     "longitude": user.longitude,
//   //     "gender": user.gender,
//   //   }),
//   // );

//   // var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
//   // var responseStatus = jsonResponse['status'];

//   print('통신 끝');

//   return response.statusCode;
// }
