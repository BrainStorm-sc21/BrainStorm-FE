import 'package:brainstorm_meokjang/pages/chat_page.dart';
import 'package:brainstorm_meokjang/pages/deal_page.dart';
import 'package:brainstorm_meokjang/pages/home_page.dart';
import 'package:brainstorm_meokjang/pages/onboarding_page.dart';
import 'package:brainstorm_meokjang/utilities/Colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const JWTestApp());
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int currentIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: IndexedStack(
//         index: currentIndex, // index 순서에 해당하는 child를 맨 위에 보여줌
//         children: [
//           HomePage(),
//           DealPage(),
//           ChatPage(),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: currentIndex, // 현재 보여주는 탭
//         onTap: (newIndex) {
//           print("selected newIndex : $newIndex");
//           // 버튼 눌렀을 때 누른 페이지로 이동
//           setState(() {
//             currentIndex = newIndex;
//           });
//         },
//         selectedItemColor: Colors.green, // 선택된 아이콘 색상
//         unselectedItemColor: Colors.grey, // 선택되지 않은 아이콘 색상
//         //label 숨기려면 사용하기
//         /* showSelectedLabels: false,
//         showUnselectedLabels: false, */
//         backgroundColor: Colors.white,
//         items: [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
//           BottomNavigationBarItem(icon: Icon(Icons.person_2), label: 'deal'),
//           BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'chat'),
//         ],
//       ),
//     );
//   }
// }

class JWTestApp extends StatelessWidget {
  const JWTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnboardingPage(),
      theme: ThemeData(
        primaryColor: ColorStyles.mainColor,
      ),
    );
  }
}
