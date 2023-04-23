import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Ingredient {
  String name; //재료 이름
  // int number; //재료 개수
  // String expirationDate; //유통기한
  bool isClick; //세부사항 클릭 여부

  // Bucket(this.name, this.number, this.expirationDate, this.isClick); // 생성자
  Ingredient(this.name, this.isClick);
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  // 식재료 리스트
  List<Ingredient> ingredientList = [];

  // 삭제 확인 다이얼로그
  void showDeleteDialog(int index) {
    // 다이얼로그 보여주기
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("정말로 삭제하시겠습니까?"),
          actions: [
            // 취소 버튼
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("취소"),
            ),
            // 확인 버튼
            TextButton(
              onPressed: () {
                setState(() {
                  // index에 해당하는 항목 삭제
                  ingredientList.removeAt(index);
                });
                Navigator.pop(context);
              },
              child: Text(
                "확인",
                style: TextStyle(color: Colors.pink),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "냉장고",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.white,
          actions: [
            IconButton(
              icon: Icon(Icons.search_outlined, color: Colors.grey),
              onPressed: () {
                print("우측 상단 검색 아이콘 클릭 됨");
              }
            ),
          ],

          bottom: TabBar(
            isScrollable: false,
            indicatorColor: Colors.green,
            indicatorWeight: 4,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
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
        body: ingredientList.isEmpty ? Center(child: Text("냉장고에 재료가 없어요!"))
          : TabBarView(
            children: [
              ListView.builder(
                itemCount: ingredientList.length, // ingredientList 개수 만큼 보여주기
                itemBuilder: (context, index) {
                Ingredient ingredient = ingredientList[index]; // index에 해당하는 ingredient 가져오기
                return ListTile(
                  //추가한 식재료 리스트
                  title: Text(
                    ingredient.name,
                    style: TextStyle(
                      fontSize: 24,
                      color: ingredient.isClick ? Colors.grey : Colors.black,
                      decoration: ingredient.isClick
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  // 삭제 아이콘 버튼
                  trailing: IconButton(
                    icon: Icon(CupertinoIcons.delete),
                    onPressed: () {
                      // 삭제 버튼 클릭시
                      showDeleteDialog(index);
                    },
                  ),
                  onTap: () {
                    // 아이템 클릭시
                    setState(() {
                      ingredient.isClick = !ingredient.isClick; // isClick 상태 변경
                    });
                  },
                );
              },
            ),

            Center(child: Text("냉장")),

            Center(child: Text("냉동")),

            Center(child: Text("상온")),
            ],
          ),
        floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          String? name = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => CreatePage()),
          );
          if (name != null) {
            setState(() {
              ingredientList.add(Ingredient(name, false)); //리스트에 추가
            });
          }
        },
      ),
      ),
    );
  }
}