import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    /// Tip : TabBar controller를 직접 TabBar에 넣어줄 수도 있고, 아래와 같이 위젯으로 감싸줄 수도 있습니다.
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Menu",
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

          /// Tip : AppBar 하단에 TabBar를 만들어 줍니다.
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
        
      ),
    );
  }
}
