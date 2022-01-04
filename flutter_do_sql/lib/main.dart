import 'package:flutter/material.dart';
import 'package:flutter_do_sql/clear_list.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'add_todo_app.dart';
import 'database_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Future<Database> database = initDatabase();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'sql Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => DatabaseApp(database),
        "/add": (context) => AddTodoApp(database),
        "/clear": (context) => ClearList(database)
      },
    );
  }

  Future<Database> initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'todo_database.db'),
      onCreate: (db, version) => db.execute(
          "CREATE TABLE todos(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT, active INTEGER)"),
      version: 1,
    );
  }
}
