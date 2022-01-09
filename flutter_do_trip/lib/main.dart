import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_do_trip/page/login_page.dart';
import 'package:flutter_do_trip/page/main_page.dart';
import 'package:flutter_do_trip/page/sign_page.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path/path.dart';
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
        '/': (context) => const LoginPage(),
        '/sign': (context) => const SignPage(),
        '/main': (context) => MainPage(database),
      },
    );
  }
}
