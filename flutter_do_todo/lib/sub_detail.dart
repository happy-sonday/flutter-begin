import 'package:flutter/material.dart';

class SubDetail extends StatefulWidget {
  const SubDetail({Key? key}) : super(key: key);

  @override
  _SubDetailState createState() => _SubDetailState();
}

class _SubDetailState extends State<SubDetail> {
  List<String> todoList = new List.empty(growable: true);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todoList.add("dart UI 공부");
    todoList.add("바닐라 자바스크립트");
    todoList.add("조깅 5km");
    todoList.add("전신 순환운동");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sub Detail Exmple'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            child: InkWell(
              child: Text(
                todoList[index],
                style: TextStyle(fontSize: 30),
              ),
              onTap: () {
                //사용자가 선택한 할일 해당 배열 요소 전달
                Navigator.of(context)
                    .pushNamed('/third', arguments: todoList[index]);
              },
            ),
          );
        },
        itemCount: todoList.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
