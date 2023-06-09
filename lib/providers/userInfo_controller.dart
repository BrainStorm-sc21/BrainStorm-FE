import 'package:brainstorm_meokjang/models/user.dart';
import 'package:brainstorm_meokjang/utilities/domain.dart';
import 'package:brainstorm_meokjang/utilities/toast.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfoController extends GetxController {
  final RxInt _userId = 0.obs;
  final RxString _userName = "".obs;
  final RxString _location = "".obs;
  final RxDouble _latitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;
  final RxDouble _reliability = 0.0.obs;
  final RxBool _isLoading = false.obs;

  get userId => _userId.value;
  get userName => _userName.value;
  get location => _location.value;
  get latitude => _latitude.value;
  get longitude => _longitude.value;
  get reliability => _reliability.value;
  get isLoading => _isLoading.value;

  Future<void> getUserIdFromSharedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _userId.value = prefs.getInt('userId') ?? -1;
  }

  Future getUserInfo(int userId) async {
    _isLoading.value = true;
    Dio dio = Dio();

    dio.options
      ..baseUrl = baseURI
      ..connectTimeout = const Duration(seconds: 5)
      ..receiveTimeout = const Duration(seconds: 10);
    try {
      final resp = await dio.get("/users/$userId");

      User user = User.fromJson(resp.data);

      _userName.value = user.userName;
      _location.value = user.location;
      _latitude.value = user.latitude;
      _longitude.value = user.longitude;
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

  Future modifyUserInfo(int userId, data) async {
    Dio dio = Dio();
    dio.options
      ..baseUrl = baseURI
      ..connectTimeout = const Duration(seconds: 5)
      ..receiveTimeout = const Duration(seconds: 10);

    try {
      final res = await dio.put("/users/$userId", data: data);

      if (res.statusCode == 200) {
        print('modify UserInfo : ${res.statusCode}');
        _userName.value = res.data['data']['userName'];
        showToast('닉네임이 수정되었습니다');
      } else {
        throw Exception('Failed to send data [${res.statusCode}]');
      }
    } on DioError catch (err) {
      print('${err.message}');
    } catch (e) {
      Exception(e);
    } finally {
      dio.close();
    }
  }

  void modifyUserName(String name) {
    _userName.value = name;
    update();
  }
}
