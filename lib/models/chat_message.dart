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
}
