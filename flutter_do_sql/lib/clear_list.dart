import 'package:flutter/material.dart';
import 'package:flutter_do_sql/todo.dart';
import 'package:sqflite/sqflite.dart';

class ClearList extends StatefulWidget {
  Future<Database> database;
  ClearList(this.database);

  @override
  _ClearListState createState() => _ClearListState();
}

class _ClearListState extends State<ClearList> {
  Future<List<Todo>>? clearList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    clearList = getClearList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("완료한 일"),
      ),
      body: Container(
        child: Center(
          child: FutureBuilder(
            future: clearList,
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
                          return ListTile(
                              title: Text(
                                todo.title!,
                                style: const TextStyle(fontSize: 20),
                              ),
                              subtitle: Container(
                                child: Column(
                                  children: [
                                    Text(todo.content!),
                                    Container(
                                      height: 1,
                                      color: Colors.blue,
                                    )
                                  ],
                                ),
                              ));
                        });
                  } else {
                    return const Text("검색 결과 없음");
                  }
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("완료한 일 삭제"),
                content: const Text("완료한 일을 모두 삭제할까요>"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: const Text("예")),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: const Text("아니오")),
                ],
              );
            },
          );
          if (result) {
            _removeAllTodos();
          }
        },
        child: const Icon(Icons.remove),
      ),
    );
  }

  void _removeAllTodos() async {
    final Database database = await widget.database;
    database.rawDelete('delete from todos where active=1');
    setState(() {
      clearList = getClearList();
    });
  }

  Future<List<Todo>> getClearList() async {
    final Database database = await widget.database;
    List<Map<String, dynamic>> maps = await database
        .rawQuery('select title, content, id from todos where active=1');

    return List.generate(maps.length, (index) {
      return Todo(
          title: maps[index]['title'].toString(),
          content: maps[index]['content'].toString(),
          id: maps[index]['id']);
    });
  }
}
