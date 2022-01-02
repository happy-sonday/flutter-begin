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
                  if (snapshot.hasData) {
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
    );
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
