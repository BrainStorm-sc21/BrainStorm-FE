import 'package:brainstorm_meokjang/models/food.dart';
import 'package:brainstorm_meokjang/pages/manual_add_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

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
    var now = DateTime.now();
    foodList.add(Food(foodId: 0, name: "토마토", storage: "냉장", stock: 2, expireDate: now));
    foodList.add(Food(foodId: 1, name: "감자", storage: "냉장", stock: 2, expireDate: now));
    foodList.add(Food(foodId: 2, name: "가지", storage: "냉장", stock: 2, expireDate: now));
    foodList.add(Food(foodId: 3, name: "버섯", storage: "냉장", stock: 2, expireDate: now));
  }

  // 삭제 확인 다이얼로그
  void showDeleteDialog(int index) {
    // 다이얼로그 보여주기
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
                  // index에 해당하는 항목 삭제
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

  bool expandedIcon = false;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "냉장고",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.white,
          actions: [
            IconButton(
                icon: const Icon(Icons.search_outlined, color: Colors.grey),
                onPressed: () {
                  print("우측 상단 검색 아이콘 클릭 됨");
                }),
          ],
          bottom: const TabBar(
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
          ),
        ),
        body: foodList.isEmpty
            ? const Center(child: Text("냉장고에 재료가 없어요!"))
            : TabBarView(
                children: [
                  ListView.builder(
                    itemCount: foodList.length, // ingredientList 개수 만큼 보여주기
                    itemBuilder: (context, index) {
                      Food food = foodList[index]; // index에 해당하는 ingredient 가져오기
                      return Card(
                        key: PageStorageKey(food.foodId),
                        child: ExpansionTile(
                          title: Text(
                            food.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          // trailing: Icon(
                          //   expandedIcon ? Icons.arrow_back : Icons.arrow_downward,
                          // ),
                          children: [
                            ListTile(
                              title: Text(food.storage, style: const TextStyle(fontSize: 15)),
                            ),
                            ListTile(
                              title: Text('${food.stock}', style: const TextStyle(fontSize: 15)),
                            ),
                            ListTile(
                              title:
                                  Text('${food.expireDate}', style: const TextStyle(fontSize: 15)),
                              // 삭제 버튼
                              trailing: IconButton(
                                icon: const Icon(CupertinoIcons.delete),
                                onPressed: () {
                                  showDeleteDialog(index);
                                },
                              ),
                            ),
                          ],
                          onExpansionChanged: (bool expanded) {
                            setState(() => expandedIcon = expanded);
                          },
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
    //배경 투명하게 할 것인지, 아닌지
    renderOverlay: false,
    //floating Button이 열려 있을 때 다른 배경 누를 시 닫게 할 것인지, 아닌지
    closeManually: false,
    children: [
      SpeedDialChild(
          child: const Icon(Icons.camera_alt, color: Colors.white),
          // label: "설정",
          // labelStyle: const TextStyle(
          //     fontWeight: FontWeight.w500,
          //     color: Colors.white,
          //     fontSize: 13.0),
          // labelBackgroundColor: Color.fromRGBO(28, 187, 217, 1),
          backgroundColor: const Color.fromRGBO(28, 187, 217, 1),
          onTap: () {}),
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
