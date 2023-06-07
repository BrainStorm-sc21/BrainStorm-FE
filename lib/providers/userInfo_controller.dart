import 'package:brainstorm_meokjang/models/user.dart';
import 'package:brainstorm_meokjang/utilities/domain.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class UserInfoController extends GetxController {
  final RxList<User> _userInfo = <User>[].obs;
  final RxString _userName = "".obs;
  final RxDouble _reliability = 0.0.obs;
  final RxBool _isLoading = false.obs;

  get userInfo => _userInfo;
  get userName => _userName.value;
  get reliability => _reliability.value;
  get isLoading => _isLoading.value;

  Future getUserInfo(int userId) async {
    _isLoading.value = true;
    userInfo.clear();

    Dio dio = Dio();

    dio.options
      ..baseUrl = baseURI
      ..connectTimeout = const Duration(seconds: 5)
      ..receiveTimeout = const Duration(seconds: 10);
    try {
      final resp = await dio.get("/users/$userId");

      User user = User.fromJson(resp.data);

      _userName.value = user.userName;
      _reliability.value = user.reliability!;
      _isLoading.value = false;
      update();
    } catch (e) {
      Exception(e);
    } finally {
      dio.close();
    }
    return false;
  }

  void modifyUserName(String name) {
    _userName.value = name;
    update();
  }
}
