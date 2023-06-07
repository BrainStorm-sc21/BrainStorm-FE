class Room {
  final int id;
  final String roomId;
  final int sender;
  final int receiver;
  final String? lastMessage;
  final DateTime? lastTime;

  Room({
    required this.id,
    required this.roomId,
    required this.sender,
    required this.receiver,
    required this.lastMessage,
    required this.lastTime,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'],
      roomId: json['roomId'],
      sender: json['sender'],
      receiver: json['receiver'],
      lastMessage: json['lastMessage'] ?? '',
      lastTime:
          json['lastTime'] == null ? null : DateTime.parse(json['lastTime']),
    );
  }
}
