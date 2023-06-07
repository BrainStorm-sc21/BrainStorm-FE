enum MessageType {
  ENTER,
  TALK,
}

class Message {
  final MessageType? type;
  final String? roomId;
  final int sender; //userId
  final String message;
  final String? time;

  Message({
    this.type,
    this.roomId,
    required this.sender,
    required this.message,
    this.time,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type!.name;
    data['roomId'] = roomId!;
    data['sender'] = sender;
    data['message'] = message;
    data['time'] = time;
    return data;
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      // type: MessageType.values
      //     .firstWhere((type) => type.name == json['type'].toString()),
      // roomId: json['roomId'].toString(),
      sender: json['sender'],
      message: json['message'],
      time: json['time'],
    );
  }
}
