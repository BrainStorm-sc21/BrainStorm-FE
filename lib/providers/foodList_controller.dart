import 'package:brainstorm_meokjang/models/food.dart';
import 'package:brainstorm_meokjang/utilities/domain.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class FoodListController extends GetxController {
  final RxList<Food> _foodList = <Food>[].obs;
  final List<bool> _isSelected = List.filled(100, false, growable: true).obs;

  final RxString _recipe = ''.obs;
  final RxBool _isLoading = false.obs;

  get foodList => _foodList;
  get isLoading => _isLoading.value;
  get isSelected => _isSelected;
  get recipe => _recipe;

  void changedSelected(int index) {
    _isSelected[index] = !_isSelected[index];
    update();
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

      FoodData foodData = FoodData.fromJson(resp.data);
      _foodList.value = foodData.data;
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
      print('delete food : ${fooditem.foodId}');
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

  Future modifyFoodInfo(int userId, Food item) async {
    Dio dio = Dio();
    dio.options
      ..baseUrl = baseURI
      ..connectTimeout = const Duration(seconds: 5)
      ..receiveTimeout = const Duration(seconds: 10);

    final data = {
      "userId": userId,
      "food": item.toJson(),
    };
    print("stock: ${item.stock}");
    print("storageWay: ${item.storageWay}");
    print("expireDate: ${item.expireDate}");

    try {
      final resp = await dio.put('/food/${item.foodId}', data: data);
      print("Modify Status: ${resp.statusCode}");

      for (var i = 0; i < _foodList.length; i++) {
        if (_foodList[i].foodId == item.foodId) {
          _foodList[i] = item;
          break;
        }
      }
      update();

      return 1;
    } catch (e) {
      Exception(e);
    } finally {
      dio.close();
    }
  }

  Future addManualFoodInfo(data) async {
    Dio dio = Dio();
    dio.options
      ..baseUrl = baseURI
      ..connectTimeout = const Duration(seconds: 5)
      ..receiveTimeout = const Duration(seconds: 10);

    try {
      final resp = await dio.post('/food/add', data: data);
      _foodList.add(Food.fromJson(resp.data['data']));
      update();
    } catch (e) {
      Exception(e);
    } finally {
      dio.close();
    }
  }

  Future getRecipe(List<String> selectedFoods) async {
    _isLoading.value = true;

    Dio dio = Dio();
    dio.options
      ..baseUrl = baseURI
      ..connectTimeout = const Duration(seconds: 30)
      ..receiveTimeout = const Duration(seconds: 60);

    Map<String, dynamic> data = {
      "foodList": selectedFoods,
    };

    try {
      final resp = await dio.post(
        "/recipe",
        data: data,
      );

      print("recipe statusCode : ${resp.statusCode}");

      _recipe.value = resp.data['data']['recipe'].toString();
      _isLoading.value = false;
      update();
    } catch (e) {
      Exception(e);
    } finally {
      dio.close();
    }
    return;
  }
}
