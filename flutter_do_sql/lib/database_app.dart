import 'package:flutter/material.dart';
import 'package:flutter_do_sql/todo.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseApp extends StatefulWidget {
  final Future<Database> db;
  const DatabaseApp(this.db);

  @override
  _DatabaseAppState createState() => _DatabaseAppState();
}

class _DatabaseAppState extends State<DatabaseApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Database Example"),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final todo = await Navigator.of(context).pushNamed('/add');
          if (todo != null) {
            _insertTodo(todo as Todo);
          }
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _insertTodo(Todo todo) async {
    //NOTE: widget.db로 database객체를 선언, 내장 메소드 insert()함수를 이용해 매개변수로 전달받은 데이터를 입력
    final Database database = await widget.db;
    await database.insert('todos', todo.toMap(),
        //NOTE: 새로 등록하려는 데이터 id값이 같을 경우 교체
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
