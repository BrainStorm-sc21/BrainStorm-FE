class Push {
  int noticeId;
  String title;
  String body;
  String type;
  String typeId;
  Push(
      {required this.noticeId,
      required this.title,
      required this.body,
      required this.type,
      required this.typeId});

  factory Push.fromJson(Map<String, dynamic> json) {
    return Push(
      noticeId: json['noticeId'],
      title: json['title'],
      body: json['body'],
      type: json['type'],
      typeId: json['typeId'],
    );
  }
}
