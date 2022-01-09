import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_do_trip/page/favorite_page.dart';
import 'package:flutter_do_trip/page/map_page.dart';
import 'package:flutter_do_trip/page/setting_page.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sqflite/sqflite.dart';

class MainPage extends StatefulWidget {
  final Future<Database> database;

  MainPage(this.database);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  final String? _dataBaseURL = dotenv.env['DB_URL'];
  TabController? controller;
  FirebaseDatabase? _database;
  DatabaseReference? reference;
  String? id;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
    _database = FirebaseDatabase(databaseURL: _dataBaseURL);
    reference = _database!.reference();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 로그인할 때 전달받은 아이디값을 저장, 각 페이지로 이동할 때마다 이 값을 전달
    id = ModalRoute.of(context)!.settings.arguments as String?;
    return Scaffold(
        body: TabBarView(
          children: [
            MapPage(
              databaseReference: reference,
              id: id,
              db: widget.database,
            ),
            FavoritePage(
              databaseReference: reference,
              id: id,
              db: widget.database,
            ),
            SettingPage()
          ],
          controller: controller,
        ),
        bottomNavigationBar: TabBar(
          tabs: const [
            Tab(
              icon: Icon(Icons.map),
            ),
            Tab(
              icon: Icon(Icons.star),
            ),
            Tab(
              icon: Icon(Icons.settings),
            ),
          ],
          labelColor: Colors.amber,
          indicatorColor: Colors.deepOrangeAccent,
          controller: controller,
        ));
  }
}
