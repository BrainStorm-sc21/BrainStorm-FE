import 'package:brainstorm_meokjang/models/food.dart';
import 'package:brainstorm_meokjang/pages/home/manual_add_page.dart';
import 'package:brainstorm_meokjang/pages/home/smart_add_page.dart';
import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:brainstorm_meokjang/widgets/food/refrigerator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:dio/dio.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Food> foodList = List.empty(growable: true);
  late FoodData foodData;

  Future getServerDataWithDio() async {
    BaseOptions options = BaseOptions(
        baseUrl: 'http://www.meokjang.com',
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5));
    Dio dio = Dio(options);
    try {
      Response resp = await dio.get("/food/1");

      print("Status: ${resp.statusCode}");
      print("Data:\n${resp.data}");

      FoodData foodData = FoodData.fromJson(resp.data);

      setState(() {
        for (Food fooditem in foodData.data) {
          foodList.add(fooditem);
        }
      });
    } catch (e) {
      Exception(e);
    } finally {
      dio.close();
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    getServerDataWithDio();
  }

  TabBar get _tabBar => const TabBar(
      padding: EdgeInsets.only(top: 10),
      isScrollable: false,
      indicatorColor: ColorStyles.mainColor,
      indicatorWeight: 4,
      labelColor: ColorStyles.mainColor,
      unselectedLabelColor: ColorStyles.textColor,
      labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      tabs: [Tab(text: "전체"), Tab(text: "냉장"), Tab(text: "냉동"), Tab(text: "실온")]);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(90.0),
              child: AppBar(
                  centerTitle: false,
                  title: const Text("@@님의 냉장고",
                      style: TextStyle(
                          height: 3,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25)),
                  backgroundColor: ColorStyles.white,
                  elevation: 0,
                  flexibleSpace: Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: <Color>[
                                Color.fromARGB(255, 87, 214, 153),
                                ColorStyles.mainColor
                              ]))),
                  actions: [
                    IconButton(
                        padding: const EdgeInsets.only(top: 28, right: 30),
                        icon: const Icon(Icons.notifications, color: Colors.white, size: 30),
                        onPressed: () {
                          print("우측 상단 검색 아이콘 클릭 됨");
                        })
                  ]),
            ),
            body: Column(children: [
              _tabBar,
              const Divider(height: 0, color: ColorStyles.lightgrey, thickness: 1.5, endIndent: 10),
              Expanded(
                  child: foodList.isEmpty
                      ? const Center(child: Text("냉장고에 재료를 추가해주세요!"))
                      : TabBarView(
                          children: [
                            Refrigerator(foodList: foodList, storage: '전체'),
                            Refrigerator(foodList: foodList, storage: '냉장'),
                            Refrigerator(foodList: foodList, storage: '냉동'),
                            Refrigerator(foodList: foodList, storage: '실온')
                          ],
                        ))
            ]),
            floatingActionButton: floatingButtons(context)));
  }
}

Widget? floatingButtons(BuildContext context) {
  return SpeedDial(
    icon: Icons.add,
    activeIcon: Icons.close,
    visible: true,
    curve: Curves.bounceIn,
    iconTheme: const IconThemeData(size: 35),
    backgroundColor: ColorStyles.mainColor,
    childPadding: const EdgeInsets.all(1),
    spaceBetweenChildren: 10,
    renderOverlay: false,
    closeManually: false,
    children: [
      SpeedDialChild(
          child: const Icon(Icons.camera_alt, color: Colors.white),
          backgroundColor: ColorStyles.mainColor,
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SmartAddPage()));
          }),
      SpeedDialChild(
        child: const Icon(
          Icons.create,
          color: Colors.white,
        ),
        backgroundColor: ColorStyles.mainColor,
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const ManualAddPage()));
        },
      )
    ],
  );
}
