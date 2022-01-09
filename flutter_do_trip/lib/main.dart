import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_do_trip/page/login_page.dart';
import 'package:flutter_do_trip/page/main_page.dart';
import 'package:flutter_do_trip/page/sign_page.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

Future main() async {
  if (defaultTargetPlatform == TargetPlatform.android) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Future<Database> initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'tour_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE place(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, tel TEXT , zipcode TEXT , address TEXT , mapx Number , mapy Number , imagePath TEXT)",
        );
      },
      version: 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    Future<Database> database = initDatabase();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '손데이 트립',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // 라우트 등록
      initialRoute: '/',
      routes: {
        '/': (context) {
          return FutureBuilder(
            future: Firebase.initializeApp(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text("Error"),
                );
              }

              if (snapshot.connectionState == ConnectionState.done) {
                _initFirebaseMessaging(context);
                return const LoginPage();
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        },
        '/sign': (context) => const SignPage(),
        '/main': (context) => MainPage(database),
      },
    );
  }

  _initFirebaseMessaging(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage event) async {
      bool? pushCheck = await _loadData();
      if (pushCheck!) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(event.notification!.title!),
                content: Text(event.notification!.body!),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("ok"))
                ],
              );
            });
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});
  }

  Future<bool?> _loadData() async {
    var key = "push";
    SharedPreferences pref = await SharedPreferences.getInstance();
    var value = pref.getBool(key);
    return value;
  }
}
