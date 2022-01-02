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
  Future<List<Todo>>? todoList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todoList = getTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Database Example"),
      ),
      body: Container(
        child: Center(
          child: Center(
            child: FutureBuilder(
              future: todoList,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                  case ConnectionState.active:
                    return const CircularProgressIndicator();
                  case ConnectionState.done:
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: (snapshot.data as List<Todo>).length,
                          itemBuilder: (context, index) {
                            Todo todo = (snapshot.data as List<Todo>)[index];
                            // return Card(
                            //   child: Column(
                            //     children: [
                            //       Text(todo.title!),
                            //       Text(todo.content!),
                            //       Text(todo.active == 1 ? 'true' : 'false'),
                            //     ],
                            //   ),
                            // );
                            return ListTile(
                              title: Text(
                                todo.title!,
                                style: const TextStyle(fontSize: 20),
                              ),
                              subtitle: Container(
                                child: Column(
                                  children: [
                                    Text(todo.content!),
                                    Text(
                                        "체크 : ${todo.active == 1 ? 'true' : 'false'}"),
                                    Container(
                                      height: 1,
                                      color: Colors.blue,
                                    )
                                  ],
                                ),
                              ),
                              onTap: () async {
                                Todo result = await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title:
                                            Text("${todo.id}: ${todo.title}"),
                                        content: const Text("Todo를 체크하시겠습니까?"),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  todo.active == 1
                                                      ? todo.active = 0
                                                      : todo.active = 1;
                                                });
                                                Navigator.of(context).pop(todo);
                                              },
                                              child: const Text("예")),
                                          TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  Navigator.of(context)
                                                      .pop(todo);
                                                });
                                              },
                                              child: const Text("아니오")),
                                        ],
                                      );
                                    });
                                _updateTodo(result);
                              },
                            );
                          });
                    } else {
                      return const Text("No data");
                    }
                }
              },
            ),
          ),
        ),
      ),
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
    setState(() {
      todoList = getTodos();
    });
  }

  void _updateTodo(Todo todo) async {
    final Database database = await widget.db;
    await database
        .update('todos', todo.toMap(), where: 'id=?', whereArgs: [todo.id]);

    setState(() {
      todoList = getTodos();
    });
  }

  Future<List<Todo>> getTodos() async {
    final Database database = await widget.db;
    final List<Map<String, dynamic>> maps = await database.query('todos');

    return List.generate(maps.length, (index) {
      int active = maps[index]['active'] == 1 ? 1 : 0;
      return Todo(
          title: maps[index]['title'].toString(),
          content: maps[index]['content'].toString(),
          active: active,
          id: maps[index]['id']);
    });
  }
}