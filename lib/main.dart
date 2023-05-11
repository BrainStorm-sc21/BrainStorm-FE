import 'package:brainstorm_meokjang/firebase_options.dart';
import 'package:brainstorm_meokjang/pages/chat/chat_page.dart';
import 'package:brainstorm_meokjang/pages/deal/map_page.dart';
import 'package:brainstorm_meokjang/pages/home/home_page.dart';
import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 날짜 선택기 및 달력에 표시되는 언어 세팅을 위한 localization
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ko', 'KR'),
        Locale('en', ''),
      ],
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: const TextTheme(
          titleLarge: TextStyle(color: ColorStyles.textColor),
          titleMedium: TextStyle(color: ColorStyles.textColor),
          titleSmall: TextStyle(color: ColorStyles.textColor),
          headlineLarge: TextStyle(color: ColorStyles.textColor),
          headlineMedium: TextStyle(color: ColorStyles.textColor),
          headlineSmall: TextStyle(color: ColorStyles.textColor),
          bodyLarge: TextStyle(color: ColorStyles.textColor),
          bodyMedium: TextStyle(color: ColorStyles.textColor),
          bodySmall: TextStyle(color: ColorStyles.textColor),
        ),
        dividerColor: ColorStyles.lightGrey,
        primaryColor: ColorStyles.mainColor,
        iconTheme: const IconThemeData(
          color: ColorStyles.iconColor,
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex, // index 순서에 해당하는 child를 맨 위에 보여줌
        children: const [
          HomePage(),
          MapPage(),
          ChatPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex, // 현재 보여주는 탭
        onTap: (newIndex) {
          print("selected newIndex : $newIndex");
          // 버튼 눌렀을 때 누른 페이지로 이동
          setState(() {
            currentIndex = newIndex;
          });
        },
        selectedItemColor: Colors.green, // 선택된 아이콘 색상
        unselectedItemColor: Colors.grey, // 선택되지 않은 아이콘 색상
        //label 숨기려면 사용하기
        /* showSelectedLabels: false,
        showUnselectedLabels: false, */
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(icon: Icon(Icons.person_2), label: 'deal'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'chat'),
        ],
      ),
    );
  }
}
