import 'package:brainstorm_meokjang/models/food.dart';
import 'package:brainstorm_meokjang/pages/home/manual_add_page.dart';
import 'package:brainstorm_meokjang/pages/home/smart_add_page.dart';
import 'package:brainstorm_meokjang/pages/pushMessage/push_list_page.dart';
import 'package:brainstorm_meokjang/providers/foodList_controller.dart';
import 'package:brainstorm_meokjang/providers/userInfo_controller.dart';
import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:brainstorm_meokjang/widgets/food/refrigerator.dart';
import 'package:brainstorm_meokjang/widgets/rounded_outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  int userId;
  HomePage({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Food> foodList = List.empty(growable: true);
  late FoodData foodData;
  late String userName = '';

  final FoodListController _foodListController = Get.put(FoodListController());
  final UserInfoController _userInfoController = Get.put(UserInfoController());

  List<Food> initFoods(String storage) {
    List<Food> storageFoods = [];
    for (Food fooditem in _foodListController.foodList) {
      if (storage == "전체" || storage == fooditem.storageWay) {
        storageFoods.add(fooditem);
      }
    }
    storageFoods.sort((a, b) => a.expireDate.compareTo(b.expireDate));
    return storageFoods;
  }

  @override
  void initState() {
    _foodListController.getServerDataWithDio(widget.userId);
    _userInfoController.getUserName(widget.userId);
    super.initState();
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
              title: Obx(() => Text("${_userInfoController.userName}님의 냉장고",
                  style: const TextStyle(
                      height: 3, color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25))),
              backgroundColor: ColorStyles.white,
              elevation: 0,
              flexibleSpace: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: <Color>[ColorStyles.darkmainColor, ColorStyles.mainColor]))),
              actions: [
                IconButton(
                    padding: const EdgeInsets.only(top: 28, right: 30),
                    icon: const Icon(Icons.notifications, color: Colors.white, size: 30),
                    onPressed: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => const PushList()));
                    })
              ]),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _tabBar,
            const Divider(height: 0, color: ColorStyles.lightgrey, thickness: 1.5, endIndent: 10),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 13, 10),
              child: RoundedOutlinedButton(
                  height: 33,
                  backgroundColor: ColorStyles.cream,
                  borderColor: ColorStyles.cream,
                  foregroundColor: ColorStyles.textColor,
                  onPressed: () {},
                  fontSize: 14,
                  text: "🧑🏻‍🍳 레시피 추천받기"),
            ),
            Expanded(
              child: Obx(() {
                if (_foodListController.isLoading) {
                  return const Center(child: Text("재료를 불러오고 있어요"));
                } else {
                  return TabBarView(
                    children: [
                      Obx(() => Refrigerator(
                          userId: widget.userId, foods: initFoods("전체"), storage: '전체')),
                      Obx(() => Refrigerator(
                          userId: widget.userId, foods: initFoods("냉장"), storage: '냉장')),
                      Obx(() => Refrigerator(
                          userId: widget.userId, foods: initFoods("냉동"), storage: '냉동')),
                      Obx(() => Refrigerator(
                          userId: widget.userId, foods: initFoods("실온"), storage: '실온'))
                    ],
                  );
                }
              }),
            )
          ],
        ),
        floatingActionButton: floatingButtons(context, widget.userId),
      ),
    );
  }
}

Widget? floatingButtons(BuildContext context, int userId) {
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
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SmartAddPage(
                          userId: userId,
                        )));
          }),
      SpeedDialChild(
        child: const Icon(
          Icons.create,
          color: Colors.white,
        ),
        backgroundColor: ColorStyles.mainColor,
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ManualAddPage(userId: userId)));
        },
      )
    ],
  );
}
