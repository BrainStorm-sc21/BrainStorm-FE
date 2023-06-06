import 'package:brainstorm_meokjang/models/food.dart';
import 'package:brainstorm_meokjang/utilities/domain.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodListController extends GetxController {
  final RxList<Food> _foodList = <Food>[].obs;
  //final RxList<TextEditingController> _foodNameController = <TextEditingController>[].obs;
  late List<Food> _checkList;
  List<Food> foodsList = List.empty(growable: true);

  final RxBool _isLoading = false.obs;

  get foodList => _foodList;
  get isLoading => _isLoading.value;

  List<Food> initController(foods) {
    for (int index = 0; index < foods.length; index++) {
      //foods.foodNameController = TextEditingController();
      foods[index].foodNameController = TextEditingController(text: foods[index].foodName);
    }
    return foods;
  }

  void disposeController() {
    for (var food in _foodList) {
      food.foodNameController!.dispose();
    }
  }

  Future getServerDataWithDio(int userId) async {
    _isLoading.value = true;

    Dio dio = Dio();
    dio.options
      ..baseUrl = baseURI
      ..connectTimeout = const Duration(seconds: 5)
      ..receiveTimeout = const Duration(seconds: 10);

    try {
      final resp = await dio.get("/food/$userId");

      print("food statusCode : ${resp.statusCode}");
      print(resp.data);

      FoodData foodData = FoodData.fromJson(resp.data);
      _foodList.value = initController(foodData.data);
      //_foodList.value = foodData.data;
      _isLoading.value = false;

      update();
    } catch (e) {
      Exception(e);
    } finally {
      dio.close();
    }
    return;
  }

  Future deleteServerDataWithDio(Food fooditem) async {
    Dio dio = Dio();
    dio.options
      ..baseUrl = baseURI
      ..connectTimeout = const Duration(seconds: 5)
      ..receiveTimeout = const Duration(seconds: 10);

    var deleteFood = fooditem.foodId;

    try {
      final resp = await dio.delete("/food/$deleteFood");
      _foodList.remove(fooditem);

      print("Delete Status: ${resp.statusCode}");
      update();
    } catch (e) {
      Exception(e);
    } finally {
      dio.close();
    }
  }

  Future modifyFoodInfo(int userId, Food fooditem) async {
    Dio dio = Dio();
    dio.options
      ..baseUrl = baseURI
      ..connectTimeout = const Duration(seconds: 5)
      ..receiveTimeout = const Duration(seconds: 10);

    final data = {
      "userId": userId,
      "food": fooditem.toJson(),
    };

    var modifyFoodId = fooditem.foodId;

    try {
      final resp = await dio.put('/food/$modifyFoodId', data: data);
      print("Modify Status: ${resp.statusCode}");

      update();
    } catch (e) {
      Exception(e);
    } finally {
      dio.close();
    }
  }
}
