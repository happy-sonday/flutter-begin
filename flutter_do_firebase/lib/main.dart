import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_do_firebase/memo_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_app.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: FirebaseApp(analytics: analytics, observer: observer),
      //home: const MemoPage(),
      home: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          // 에러발생시 출력 위젯
          if (snapshot.hasError) {
            return const Center(
              child: Text("Error"),
            );
          }

          // 선언 완료 후 표시할 위젯
          if (snapshot.connectionState == ConnectionState.done) {
            _initFirebaseMessagin(context);
            _getToken();
            return const MemoPage();
          }

          // 선언되는 동안 표시할 위젯
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  _initFirebaseMessagin(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print(event.notification!.title);
      print(event.notification!.body);
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text("알림"),
                content: Text(event.notification!.body!),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Ok"))
                ],
              ));
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage event) {});
  }

  _getToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    print("messaging.getToken(),${await messaging.getToken()}");
  }
}
