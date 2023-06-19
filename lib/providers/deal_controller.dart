import 'package:brainstorm_meokjang/models/deal.dart';
import 'package:brainstorm_meokjang/utilities/domain.dart';
import 'package:brainstorm_meokjang/utilities/toast.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class DealListController extends GetxController {
  final RxList<Deal> _entirePosts = <Deal>[].obs;
  final RxList<Deal> _changePosts = <Deal>[].obs;
  final RxBool _isLoading = false.obs;

  get entirePosts => _entirePosts;
  get changePosts => _changePosts;
  get isLoading => _isLoading.value;

  Future getServerDealDataWithDio(int userId) async {
    _isLoading.value = true;

    Dio dio = Dio();
    dio.options
      ..baseUrl = baseURI
      ..connectTimeout = const Duration(seconds: 5)
      ..receiveTimeout = const Duration(seconds: 10);
    try {
      final resp = await dio.get("/deal/$userId/around");

      print("Deal Status: ${resp.statusCode}");

      DealData dealData = DealData.fromJson(resp.data);
      _entirePosts.value = dealData.data;
      _changePosts.value = dealData.data;

      _isLoading.value = false;

      update();
    } catch (e) {
      Exception(e);
    } finally {
      dio.close();
    }
    return false;
  }

  Future requestRegisterPost(int userId, Deal deal, formData) async {
    Dio dio = Dio();
    dio.options
      ..baseUrl = baseURI
      ..connectTimeout = const Duration(seconds: 5)
      ..receiveTimeout = const Duration(seconds: 10)
      ..contentType = 'multipart/form-data';

    try {
      final res = await dio.post(
        '/deal',
        data: formData,
      );

      if (res.data['status'] == 200) {
        print("Register Status: ${res.statusCode}");
        _entirePosts.add(deal);
        showToast('게시글이 등록되었습니다');
        update();
      } else if (res.data['status'] == 400) {
        throw Exception(res.data['message']);
      } else {
        throw Exception('Failed to send data [${res.statusCode}]');
      }
    } catch (e) {
      Exception(e);
    } finally {
      dio.close();
    }
  }

  Future deleteDeal(Deal deal) async {
    Dio dio = Dio();
    dio.options
      ..baseUrl = baseURI
      ..connectTimeout = const Duration(seconds: 5)
      ..receiveTimeout = const Duration(seconds: 10);

    try {
      final resp = await dio.delete("/deal/${deal.dealId}");
      print("Delete Status: ${resp.statusCode}");

      if (resp.data['status'] == 200) {
        for (var i = 0; i < _changePosts.length; i++) {
          if (_changePosts[i].dealId == deal.dealId) {
            _changePosts.removeAt(i);
          }
        }
        for (var i = 0; i < _entirePosts.length; i++) {
          if (_entirePosts[i].dealId == deal.dealId) {
            _entirePosts.removeAt(i);
          }
        }
        //_entirePosts.remove(deal);
        // _changePosts.remove(deal);
        // if (_changePosts.contains(deal)) {
        //   _changePosts.remove(deal);
        // }
        update();
        print('삭제 성공!');
        Get.back();
      } else {
        print('??');
      }
    } catch (e) {
      Exception(e);
      print(e);
    } finally {
      dio.close();
    }
  }

  void changeDeal(List<Deal> deal) {
    _changePosts.value = deal;
    update();
  }

  void sortDeal(String value) {
    if (value == '가까운순') {
      _changePosts.sort((a, b) => a.distance!.compareTo(b.distance!));
    } else if (value == '최신순') {
      _changePosts.sort((b, a) => a.createdAt.compareTo(b.createdAt));
    }
    _changePosts.sort((a, b) => a.distance!.compareTo(b.distance!));
    update();
  }
}
