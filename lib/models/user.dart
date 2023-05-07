import 'dart:ffi';

class User {
  int userId;
  String userName;
  String? phoneNumber;
  int snsConnet;
  Position pos;
  int gender;
  Float reliability;
  DateTime? stopUntil;
  DateTime createdAt;

  User(this.userId, this.userName, this.phoneNumber, this.snsConnet, this.pos, this.gender,
      this.reliability, this.createdAt);
}

class Position {
  String address;
  Float latitude;
  Float longitude;

  Position(this.address, this.latitude, this.longitude);
}
