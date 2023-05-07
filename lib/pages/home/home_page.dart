import 'package:brainstorm_meokjang/models/food.dart';
import 'package:brainstorm_meokjang/pages/home/manual_add_page.dart';
import 'package:brainstorm_meokjang/pages/home/smart_add_page.dart';
import 'package:brainstorm_meokjang/widgets/refrigerator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 식재료 리스트
  List<Food> foodList = List.empty(growable: true);

  @override
  void initState() {
    super.initState();

    var now = DateFormat('yyyy-MM-dd').parse('${DateTime.now()}');
    foodList = [
      Food(foodId: 0, name: "토마토", storage: "냉장", stock: 2, expireDate: now),
      Food(foodId: 1, name: "감자", storage: "실온", stock: 5, expireDate: now),
      Food(foodId: 2, name: "가지", storage: "냉동", stock: 1, expireDate: now),
      Food(foodId: 3, name: "버섯", storage: "냉장", stock: 4, expireDate: now),
    ];
  }

  TabBar get _tabBar => const TabBar(
        isScrollable: false,
        indicatorColor: Colors.green,
        indicatorWeight: 4,
        labelColor: Colors.green,
        unselectedLabelColor: Colors.black,
        labelStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        tabs: [
          Tab(text: "전체"),
          Tab(text: "냉장"),
          Tab(text: "냉동"),
          Tab(text: "상온"),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(130.0),
          child: AppBar(
            centerTitle: true,
            title: const Text(
              "냉장고",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[
                    Colors.greenAccent,
                    Color.fromARGB(255, 37, 182, 42),
                  ])),
            ),
            actions: [
              IconButton(
                  icon: const Icon(Icons.search_outlined, color: Colors.white),
                  onPressed: () {
                    print("우측 상단 검색 아이콘 클릭 됨");
                  }),
            ],
            bottom: PreferredSize(
              preferredSize: _tabBar.preferredSize,
              child: Material(
                color: Colors.white,
                child: _tabBar,
              ),
            ),
          ),
        ),
        body: foodList.isEmpty
            ? const Center(child: Text("냉장고에 재료를 추가해주세요!"))
            : const TabBarView(
                children: [
                  Refrigerator(storage: '전체'),
                  Refrigerator(storage: '냉장'),
                  Refrigerator(storage: '냉동'),
                  Refrigerator(storage: '실온'),
                ],
              ),
        floatingActionButton: floatingButtons(context),
      ),
    );
  }
}

Widget? floatingButtons(BuildContext context) {
  return SpeedDial(
    icon: Icons.add,
    activeIcon: Icons.close,
    visible: true,
    curve: Curves.bounceIn,
    backgroundColor: const Color.fromRGBO(28, 187, 217, 1),
    childPadding: const EdgeInsets.all(1),
    spaceBetweenChildren: 10,
    renderOverlay: false,
    closeManually: false,
    children: [
      SpeedDialChild(
          child: const Icon(Icons.camera_alt, color: Colors.white),
          backgroundColor: const Color.fromRGBO(28, 187, 217, 1),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SmartAddPage()));
          }),
      SpeedDialChild(
        child: const Icon(
          Icons.create,
          color: Colors.white,
        ),
        backgroundColor: const Color.fromRGBO(28, 187, 217, 1),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const ManualAddPage()));
        },
      )
    ],
  );
}
