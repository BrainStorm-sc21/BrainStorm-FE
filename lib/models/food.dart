class Food {
  final String name;
  final String storage;
  final num stock;
  final DateTime expireDate;

  Food({
    required this.name,
    required this.storage,
    required this.stock,
    required this.expireDate,
  });

  // class to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['storage'] = storage;
    data['stock'] = stock;
    data['expireDate'] = expireDate.toIso8601String();
    return data;
  }

  // class from json
  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      name: json['name'],
      storage: json['storage'],
      stock: json['stock'],
      expireDate: DateTime.parse(json['expireDate']),
    );
  }
}
