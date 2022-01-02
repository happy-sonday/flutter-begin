import 'package:flutter/material.dart';
import 'package:flutter_do_sql/todo.dart';
import 'package:sqflite/sqflite.dart';

class AddTodoApp extends StatefulWidget {
  final Future<Database> db;
  const AddTodoApp(this.db);

  @override
  _AddTodoAppState createState() => _AddTodoAppState();
}

class _AddTodoAppState extends State<AddTodoApp> {
  TextEditingController? titleController;
  TextEditingController? contnetController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController = TextEditingController();
    contnetController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo 추가"),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: "제목"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: contnetController,
                  decoration: const InputDecoration(labelText: "내용"),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    Todo todo = Todo(
                        title: titleController!.value.text,
                        content: contnetController!.value.text,
                        active: 0);
                    // NOTE: pop을 호춣면서 이동될 페이지에 데이터를 전달할 수 있다.
                    Navigator.of(context).pop(todo);
                  },
                  child: const Text("저장하기"))
            ],
          ),
        ),
      ),
    );
  }
}
