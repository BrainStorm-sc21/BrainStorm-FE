import 'package:brainstorm_meokjang/models/food.dart';
import 'package:brainstorm_meokjang/pages/manual_add_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../widgets/all.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 식재료 리스트
  List<Food> foodList = List.empty(growable: true);
  late Food food;
  late final TextEditingController _stockStringController = TextEditingController();
  late final FocusNode _stockFocusNode = FocusNode();

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

    food = Food(
      foodId: 1,
      name: '',
      storage: '냉장',
      stock: 1,
      expireDate: DateFormat('yyyy-MM-dd').parse('${DateTime.now()}'),
    );
    //_stockStringController.text = food.stock.toString();
  }

  void setStock(num value) => setState(() => food.stock = value);
  void setStorage(int index, String value) => setState(() => foodList[index].storage = value);
  void setExpireDate(DateTime value, {int? index}) =>
      setState(() => foodList[index!].expireDate = value);
  void updateControllerText() =>
      setState(() => _stockStringController.text = food.stock.toString());

  @override
  void dispose() {
    _stockStringController.dispose();
    _stockFocusNode.dispose();
    super.dispose();
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
                    Colors.green,
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
            : TabBarView(
                children: [
                  ListView.builder(
                    itemCount: foodList.length,
                    itemBuilder: (context, index) {
                      food = foodList[index];
                      return Card(
                        key: PageStorageKey(food.foodId),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                        child: ExpansionTile(
                          title: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  food.name,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: Color.fromARGB(255, 65, 60, 60),
                                      fontWeight: FontWeight.bold),
                                ),
                                progressBars(context),
                              ],
                            ),
                          ),
                          children: [
                            SizedBox(
                              width: 350,
                              child: FoodStorageDropdown(
                                  index: index, storage: food.storage, setStorage: setStorage),
                            ),
                            // SizedBox(
                            //   width: 350,
                            //   child: FoodStock(
                            //       stock: food.stock,
                            //       setStock: setStock,
                            //       controller: _stockStringController,
                            //       updateControllerText: updateControllerText,
                            //       focusNode: _stockFocusNode),
                            // ),
                            SizedBox(
                              width: 350,
                              child: FoodExpireDate(
                                  index: index,
                                  expireDate: food.expireDate,
                                  setExpireDate: setExpireDate),
                            ),

                            // Container(
                            //   child: ListTile(
                            //     // 삭제 버튼
                            //     title: const Text('a'),
                            //     trailing: Row(
                            //       mainAxisAlignment: MainAxisAlignment.end,
                            //       children: [
                            //         OutlinedButton(
                            //           onPressed: () {
                            //             //showDeleteDialog(index);
                            //           },
                            //           child:
                            //               const Text('수정', style: TextStyle(color: Colors.green)),
                            //         ),
                            //         //const SizedBox(width: 10),
                            //         OutlinedButton(
                            //           child:
                            //               const Text('삭제', style: TextStyle(color: Colors.green)),
                            //           onPressed: () {
                            //             showDeleteDialog(index);
                            //           },
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      );
                    },
                  ),
                  const Center(child: Text("냉장")),
                  const Center(child: Text("냉동")),
                  const Center(child: Text("상온")),
                ],
              ),
        floatingActionButton: floatingButtons(context),
      ),
    );
  }

  // 삭제 확인 다이얼로그
  void showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("정말로 삭제하시겠습니까?"),
          actions: [
            // 취소 버튼
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("취소"),
            ),
            // 확인 버튼
            TextButton(
              onPressed: () {
                setState(() {
                  foodList.removeAt(index);
                });
                Navigator.pop(context);
              },
              child: const Text(
                "확인",
                style: TextStyle(color: Colors.pink),
              ),
            ),
          ],
        );
      },
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
            //Navigator.push(context, MaterialPageRoute(builder: (context) => const SmartAdd()));
          }),
      SpeedDialChild(
        child: const Icon(
          Icons.create,
          color: Colors.white,
        ),
        backgroundColor: const Color.fromRGBO(28, 187, 217, 1),
        // label: "내 기록",
        // labelBackgroundColor: Color.fromRGBO(28, 187, 217, 1),
        // labelStyle: const TextStyle(
        //     fontWeight: FontWeight.w500, color: Colors.white, fontSize: 13.0),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const ManualAddPage()));
        },
      )
    ],
  );
}

Widget progressBars(BuildContext context) {
  return const Padding(
      padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
      child: (StepProgressIndicator(
        totalSteps: 7,
        currentStep: 4,
        size: 8,
        padding: 0,
        selectedColor: Colors.yellow,
        unselectedColor: Colors.cyan,
        roundedEdges: Radius.circular(10),
        selectedGradientColor: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.redAccent, Colors.yellowAccent],
        ),
        unselectedGradientColor: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blueGrey, Colors.grey],
        ),
      )));
}
