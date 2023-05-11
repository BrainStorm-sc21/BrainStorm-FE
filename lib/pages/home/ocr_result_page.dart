import 'package:brainstorm_meokjang/models/food.dart';
import 'package:brainstorm_meokjang/pages/home/loading_page.dart';
import 'package:brainstorm_meokjang/utilities/Colors.dart';
import 'package:brainstorm_meokjang/widgets/all.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OCRResultPage extends StatefulWidget {
  final Image image;

  const OCRResultPage({super.key, required this.image});

  @override
  State<OCRResultPage> createState() => _OCRResultPageState();
}

class _OCRResultPageState extends State<OCRResultPage> {
  List<Food> foods = List.empty(growable: true);
  final List<TextEditingController> _foodNameController = [];
  late bool _isLoading;
  Map<String, Map<int, Map<String, dynamic>>> ocrResult = {
    'list': {
      0: {
        'food_name': '오! 감자',
        'stock': 1,
      },
      1: {
        'food_name': '된장찌개양념',
        'stock': 2,
      },
      2: {
        'food_name': '깐양파',
        'stock': 3,
      },
      3: {
        'food_name': '오오오.. 감자',
        'stock': 1,
      },
      4: {
        'food_name': '군만둥',
        'stock': 2,
      },
      5: {
        'food_name': '청경채',
        'stock': 3,
      },
    },
    'recommend': {
      0: {
        '냉장': 7,
        '냉동': 60,
        '실온': 3,
      },
      3: {
        '냉장': 70,
        '냉동': 5,
        '실온': 5,
      },
    },
  };

  @override
  void initState() {
    super.initState();
    initLoading();
    initFoods();
    initController();
  }

  void initLoading() {
    _isLoading = true;
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void initFoods() {
    for (var fooditem in ocrResult['list']!.values) {
      foods.add(Food(
        name: fooditem['food_name'],
        stock: fooditem['stock'],
        storage: '냉장',
        expireDate: DateFormat('yyyy-MM-dd').parse('${DateTime.now()}'),
      ));
    }
  }

  void initController() {
    for (int index = 0; index < foods.length; index++) {
      _foodNameController.add(TextEditingController());
      _foodNameController[index].text = foods[index].name;
    }
  }

  @override
  void dispose() {
    disposeController();
    super.dispose();
  }

  void disposeController() {
    for (var controller in _foodNameController) {
      controller.dispose();
    }
  }

  void setStorage(int index, String value) {
    setState(() => foods[index].storage = value);
  }

  void setStock(int index, num value) {
    setState(() => foods[index].stock = value);
  }

  void setExpireDate(DateTime value, {int? index}) {
    setState(() => foods[index!].expireDate = value);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const LoadingPage();
    } else {
      return AddFoodLayout(
        title: '식품 등록',
        onPressedAddButton: saveFoodInfo,
        containerColor: ColorStyles.snow,
        body: SliverList.builder(
          itemCount: foods.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 0.5,
              margin: const EdgeInsets.only(bottom: 10),
              color: ColorStyles.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 200.0,
                          child: TextField(
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                            controller: _foodNameController[index],
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            foods.remove(foods[index]);
                          },
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                    FoodStorageDropdown(
                      index: index,
                      storage: foods[index].storage,
                      setStorage: setStorage,
                    ),
                    FoodStockButton(
                      index: index,
                      stock: foods[index].stock,
                      setStock: setStock,
                    ),
                    FoodExpireDate(
                      index: index,
                      expireDate: foods[index].expireDate,
                      setExpireDate: setExpireDate,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }
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
