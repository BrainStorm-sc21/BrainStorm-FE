class Food {
  late int foodId;
  String foodName;
  String storageWay;
  num stock;
  DateTime expireDate;

  Food({
    this.foodId = 0,
    required this.foodName,
    required this.storageWay,
    required this.stock,
    required this.expireDate,
  });

  // class to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['foodId'] = foodId;
    data['name'] = foodName;
    data['storage'] = storageWay;
    data['stock'] = stock;
    data['expireDate'] = expireDate;
    return data;
  }

  // class from json
  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      foodId: json['foodId'],
      foodName: json['name'],
      storageWay: json['storage'],
      stock: json['stock'],
      expireDate: DateTime.parse(json['expireDate']),
    );
  }

  // validate food information
  bool isFoodValid() {
    if (foodName.trim().isEmpty || foodName.startsWith(' ')) {
      return false;
    } else if (foodName.trim().isEmpty || foodName.startsWith(' ')) {
      return false;
    } else if (stock <= 0) {
      return false;
    }
    return true;
  }
}
