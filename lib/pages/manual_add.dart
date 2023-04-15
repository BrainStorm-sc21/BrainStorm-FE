import 'package:flutter/material.dart';

class ManualAdd extends StatelessWidget {
  const ManualAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "식품 등록",
        ),
        centerTitle: true,
      ),
      body: const FoodInfo(),
    );
  }
}

class FoodInfo extends StatefulWidget {
  const FoodInfo({super.key});

  @override
  State<FoodInfo> createState() => _FoodInfoState();
}

class _FoodInfoState extends State<FoodInfo> {
  List<String> storageList = ['냉장', '냉동', '실온'];

  // 식료품 정보(이름, 보관장소, 수량, 소비기한)를 나타내는 변수
  late String name;
  String storage = '냉장';
  num stock = 1;
  DateTime expireDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 식료품 이름 입력
        TextField(
          decoration: const InputDecoration(hintText: '식품 이름을 입력하세요'),
          onChanged: (value) {
            setState(() {
              name = value;
            });
          },
        ),
        // 보관 장소 선택
        const Row(children: [
          Text("보관 장소"),
          Spacer(),
          Icon(Icons.question_mark),
          Text("OO 보관을 추천해요"),
        ]),
        Wrap(
          spacing: 5.0,
          children: List<Widget>.generate(3, (index) {
            return ChoiceChip(
              label: Text(storageList[index]),
              selected: storage == storageList[index],
              onSelected: (selected) {
                setState(() {
                  storage = storageList[index];
                });
              },
            );
          }),
        ),
        // 구분선
        const Divider(
          thickness: 1,
          height: 1,
        ),
        // 수량 조절

        // 소비기한 입력
      ],
    );
  }
}
