import 'dart:ffi';

class User {
  int user_id;
  String user_name;
  String? phone_number;
  int sns_connet;
  Position pos;
  int gender;
  Float reliability;
  DateTime? stop_until;
  DateTime created_at;

  User(this.user_id, this.user_name, this.phone_number, this.sns_connet,
      this.pos, this.gender, this.reliability, this.created_at);
}

class Position {
  String address;
  Float latitude;
  Float longitude;

  Position(this.address, this.latitude, this.longitude);
}
