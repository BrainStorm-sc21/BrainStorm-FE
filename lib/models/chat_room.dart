class Room {
  final int id;
  final String roomId;
  final int sender;
  final int receiver;

  Room({
    required this.id,
    required this.roomId,
    required this.sender,
    required this.receiver,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: int.parse(json['id']),
      roomId: json['roomId'].toString(),
      sender: int.parse(json['sender']),
      receiver: int.parse(json['receiver']),
    );
  }
}
