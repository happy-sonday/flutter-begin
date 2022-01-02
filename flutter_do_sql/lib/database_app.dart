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
        actions: [
          TextButton(
              onPressed: () async {
                await Navigator.of(context).pushNamed('/clear');
                setState(() {
                  todoList = getTodos();
                });
              },
              child: const Text(
                '완료한 일',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: Center(
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
                  if (snapshot.hasData &&
                      (snapshot.data as List<Todo>).isNotEmpty) {
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
                              TextEditingController controller =
                                  TextEditingController(text: todo.content);

                              Todo result = await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("${todo.id}: ${todo.title}"),
                                      // content: const Text("Todo를 체크하시겠습니까?"),
                                      content: TextField(
                                        controller: controller,
                                        keyboardType: TextInputType.text,
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              setState(() {
                                                todo.active == 1
                                                    ? todo.active = 0
                                                    : todo.active = 1;
                                                todo.content =
                                                    controller.value.text;
                                              });
                                              Navigator.of(context).pop(todo);
                                            },
                                            child: const Text("예")),
                                        TextButton(
                                            onPressed: () {
                                              setState(() {
                                                Navigator.of(context).pop(todo);
                                              });
                                            },
                                            child: const Text("아니오")),
                                      ],
                                    );
                                  });
                              _updateTodo(result);
                            },
                            onLongPress: () async {
                              dynamic result = await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("${todo.id}: ${todo.title}"),
                                      content:
                                          Text("${todo.content}를 삭제하시겠습니까?"),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(todo);
                                            },
                                            child: const Text("예")),
                                        TextButton(
                                            onPressed: () {
                                              // 반환값이 null로 넘어가 throw 에러 발생
                                              Navigator.of(context).pop('');
                                            },
                                            child: const Text("아니오"))
                                      ],
                                    );
                                  });
                              // Todo의 타입일때 삭제
                              if (result is Todo) _deleteTodo(result);
                            },
                          );
                        });
                  } else {
                    return const Text("검색 결과 없음");
                  }
              }
            },
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () async {
              final todo = await Navigator.of(context).pushNamed('/add');
              if (todo != null) {
                _insertTodo(todo as Todo);
              }
            },
            heroTag: null,
            child: const Icon(Icons.add),
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: () async {
              _allUpdate();
            },
            heroTag: null,
            child: const Icon(Icons.update),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void _allUpdate() async {
    final Database database = await widget.db;
    await database.rawUpdate('update todos set active = 1 where active = 0');
    setState(() {
      todoList = getTodos();
    });
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

  void _deleteTodo(Todo todo) async {
    final Database database = await widget.db;
    await database.delete('todos', where: 'id=?', whereArgs: [todo.id]);
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
