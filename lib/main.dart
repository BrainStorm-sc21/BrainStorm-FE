import 'package:brainstorm_meokjang/app_pages_container.dart';
import 'package:brainstorm_meokjang/firebase_options.dart';
import 'package:brainstorm_meokjang/utilities/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(const MyApp());
  } catch (e) {
    debugPrint('$e');
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  dynamic userId;
  late bool isMeokjangUser = false;

  void checkMeokjangUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isMeokjangUser = prefs.getBool('isUser') ?? false;
  }

  @override
  void initState() {
    checkMeokjangUser();

    super.initState();
  }

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
        //home: isMeokjangUser ? const AppPagesContainer() : const OnboardingPage(),
        home: const AppPagesContainer());
  }
}
