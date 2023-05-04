import 'package:brainstorm_meokjang/models/food.dart';
import 'package:brainstorm_meokjang/pages/loading_page.dart';
import 'package:brainstorm_meokjang/widgets/all.dart';
import 'package:flutter/material.dart';

class OCRResultPage extends StatefulWidget {
  final Image image;

  const OCRResultPage({super.key, required this.image});

  @override
  State<OCRResultPage> createState() => _OCRResultPageState();
}

class _OCRResultPageState extends State<OCRResultPage> {
  List<Food> foods = List.empty(growable: true);
  late bool _isLoading;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _isLoading
          ? const LoadingPage()
          : AddFoodLayout(
              title: '식품 등록',
              body: Column(children: const []),
              onPressedAddButton: saveFoodInfo,
            ),
    );
  }

  // 입력한 식료품 정보를 DB에 저장하는 함수
  void saveFoodInfo() {
    for (var food in foods) {
      if (food.isFoodValid() == false) return;
    }

    for (var food in foods) {
      debugPrint('${food.toJson()}');
    }

    // 추후 DB에 저장하는 로직 구현 필요
  }
}
