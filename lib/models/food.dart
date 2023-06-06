import 'package:flutter/cupertino.dart';

class FoodData {
  final List<Food> data;

  FoodData({required this.data});

  factory FoodData.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<Food> foodList = list.map((i) => Food.fromJson(i)).toList();

    return FoodData(data: foodList);
  }
}

class Food {
  late int? foodId;
  String foodName;
  String storageWay;
  num stock;
  DateTime expireDate;
  late TextEditingController? foodNameController;

  Food({
    this.foodId,
    required this.foodName,
    required this.storageWay,
    required this.stock,
    required this.expireDate,
    this.foodNameController,
  });

  // class to json
  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    // if (foodId != null) data['foodId'] = foodId.toString();
    data['foodName'] = foodName;
    data['stock'] = stock.toString();
    data['expireDate'] = expireDate.toString().substring(0, 10);
    data['storageWay'] = storageWay;
    return data;
  }

  // class from json
  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      foodId: json['foodId'],
      foodName: json['foodName'],
      storageWay: json['storageWay'],
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
