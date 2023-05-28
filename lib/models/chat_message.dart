enum MessageType {
  ENTER,
  TALK,
}

class Message {
  final MessageType type;
  final int sender; //userId
  final String message;
  final DateTime date;

  Message({
    required this.type,
    required this.sender,
    required this.message,
    required this.date,
  });

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data['type'] = type.name;
    data['sender'] = sender.toString();
    data['message'] = message;
    data['date'] = date.toString();
    return data;
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      type: MessageType.values.firstWhere((type) => type.name == json['type']),
      sender: int.parse(json['sender']),
      message: json['message'],
      date: DateTime.parse(json['date']),
    );
  }
}
