import 'package:brainstorm_meokjang/pages/profile/reviewHistory.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationController extends GetxController {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  @override
  void onInit() async {
    // 첫 빌드시, 권한 확인
    // 아이폰은 무조건 받아야 하고, 안드로이드는 상관 없음. 따로 유저가 설정하지 않는 한,
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    print(settings.authorizationStatus);
    //_getToken();
    _onMessage();
    super.onInit();
  }

  //토큰 얻는 메소드, 회원가입시 한번만 되도록 수정하기
  void _getToken() async {
    String? token = await messaging.getToken();
    try {
      print(token);
    } catch (e) {}
  }

  final AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.max,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void _onMessage() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await flutterLocalNotificationsPlugin.initialize(
        const InitializationSettings(
            android: AndroidInitializationSettings('@mipmap/ic_launcher'),
            iOS: DarwinInitializationSettings()),
        onDidReceiveNotificationResponse: (details) => {});

    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // 종료상태에서 클릭한 푸시 알림 메세지 핸들링
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // 앱이 백그라운드 상태에서 푸시 알림 클릭 하여 열릴 경우 메세지 스트림을 통해 처리
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);

    /// foreground 메세지
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   RemoteNotification? notification = message.notification;
    //   AndroidNotification? android = message.notification?.android;

    //   // android 일 때만
    //   if (notification != null && android != null) {
    //     flutterLocalNotificationsPlugin.show(
    //         notification.hashCode,
    //         notification.title,
    //         notification.body,
    //         NotificationDetails(
    //           android: AndroidNotificationDetails(channel.id, channel.name,
    //               channelDescription: channel.description),
    //         ),

    //         // 넘길 데이터 있으면 아래코드 쓰기.
    //         payload: message.data['type']);
    //   }

    //   //데이터 잘 받는지 테스트용 코드
    //   print('foreground 상황에서 메시지를 받았다.');
    //   print('Message data: ${message.data}');
    //   print('Message type: ${message.data['type']}');
    //   if (message.notification != null) {
    //     print(
    //         'Message also contained a notification: ${message.notification!.body}');
    //   }
    //   if (message.data['type'] == '0') {
    //     //채팅
    //     print('채팅으로 이동');
    //   } else if (message.data['type'] == 1) {
    //     //후기 받음
    //     print('후기 받음으로 이동');
    //   } else if (message.data['type'] == 2) {
    //     //후기 작성
    //     print('후기 작성으로 이동');
    //   } else if (message.data['type'] == 2) {
    //     //소비기한
    //     print('소비기한으로 이동');
    //     //Get.toNamed('/chat', arguments: message.data);
    //   }
    // });
  }

  void _handleMessage(RemoteMessage message) {
    print('백그라운드 메세지 받았다!!!!!!!!!!!');

    //0: 채팅 1: 후기작성 2: 후기받음 3: 소비기한
    if (message.data['type'] == '0') {
      print('채팅으로 이동');
    } else if (message.data['type'] == '1') {
      print('후기 작성으로 이동');
    } else if (message.data['type'] == '2') {
      print('후기 받음으로 이동');
      Get.to(() => const ReviewHistoryPage(userId: 7),
          arguments: message.data['sender']);
    } else if (message.data['type'] == '3') {
      print('소비기한으로 이동');
    }
  }
}
