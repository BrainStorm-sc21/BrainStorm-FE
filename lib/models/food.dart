class Food {
  late int foodId;
  String name;
  String storage;
  num stock;
  DateTime expireDate;

  Food({
    this.foodId = 0,
    required this.name,
    required this.storage,
    required this.stock,
    required this.expireDate,
  });

  // class to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['foodId'] = foodId;
    data['name'] = name;
    data['storage'] = storage;
    data['stock'] = stock;
    data['expireDate'] = expireDate;
    return data;
  }

  // class from json
  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      foodId: json['foodId'],
      name: json['name'],
      storage: json['storage'],
      stock: json['stock'],
      expireDate: DateTime.parse(json['expireDate']),
    );
  }

  // validate food information
  bool isFoodValid() {
    if (name.trim().isEmpty || name.startsWith(' ')) {
      return false;
    } else if (name.trim().isEmpty || name.startsWith(' ')) {
      return false;
    } else if (stock <= 0) {
      return false;
    }
    return true;
  }
}
