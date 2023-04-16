import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  // 식재료 리스트
  final List<Map<String, String>> menu = const [
    {
      "name": "토마토",
      "number": "1 개",
      "expiration date": "2023.04.16 ~ 2023.04.30",
      "imgUrl": "https://cdn.pixabay.com/photo/2021/10/14/03/19/tomato-6707992__340.png",
    },
    {
      "name": "가지",
      "number": "2 개",
      "expiration date": "2023.04.10 ~ 2023.04.20",
      "imgUrl": "https://post-phinf.pstatic.net/MjAyMTA1MThfMTMz/MDAxNjIxMzE0NDc1MjMx.4XcLoNt4yilF-Ft2DvkcNlVWe49_gbLK2C_Fl5PaSVUg.gXNr_lzrDYOv21unbsZQ1Wzd4rbGedzVlzN9TGlbVfQg.JPEG/kolesnikovserg.jpg?type=w1200",
    },
    {
      "name": "사과",
      "number": "5 개",
      "expiration date": "2023.04.12~2023.04.29",
      "imgUrl": "https://img.freepik.com/premium-photo/red-apples-isolated-on-white-background-ripe-fresh-apples-clipping-path-apple-with-leaf_299651-595.jpg",
    },
    {
      "name": "양파",
      "number": "5 개",
      "expiration date": "2023.04.17~2023.05.01",
      "imgUrl": "https://media.istockphoto.com/id/517938136/ko/%EC%82%AC%EC%A7%84/%EC%8B%A0%EC%84%A0%ED%95%9C-%EC%96%91%ED%8C%8C%ED%98%95-%EC%A0%84%EA%B5%AC-%EA%B3%A0%EB%A6%BD-%EC%9D%B8%EB%AA%85%EB%B3%84-%ED%81%B4%EB%A6%AC%ED%95%91-%EA%B2%BD%EB%A1%9C.jpg?s=612x612&w=0&k=20&c=NjBydV3aSjVteo-otxL_F5UgfVHqEGjevPGA3GqKi78=",
    },
  ];

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
              Tab(text: "전체 냉장고"),
              Tab(text: "냉장"),
              Tab(text: "냉동"),
              Tab(text: "상온"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView.builder(
              itemCount: 100,
              itemBuilder: (context, index) {
              final item = menu[index % menu.length];
              final name = item["name"] ?? "이름";
              final number = item["number"] ?? "개수";
              final expirationDate = item["expiration date"] ?? "유통기한";
              final imgUrl = item["imgUrl"] ?? "";
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 21,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 52,
                      // Tip : circleAvatar 배경에 맞춰서 동그랗게 이미지 넣는 방법
                      backgroundImage: NetworkImage(imgUrl),
                      backgroundColor: Colors.transparent,
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          number,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          expirationDate,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),

          Center(child: Text("냉장")),

          Center(child: Text("냉동")),

          Center(child: Text("상온")),
          ],
        ),
      ),
    );
  }
}
