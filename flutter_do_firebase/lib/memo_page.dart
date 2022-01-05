import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_do_firebase/memoDetail.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'memo.dart';
import 'memo_add_page.dart';

class MemoPage extends StatefulWidget {
  const MemoPage({Key? key}) : super(key: key);

  @override
  _MemoPageState createState() => _MemoPageState();
}

class _MemoPageState extends State<MemoPage> {
  FirebaseDatabase? _database;
  DatabaseReference? reference;

  final String? _databaseURL = dotenv.env['DBURL'];
  List<Memo> memos = List.empty(growable: true);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _database = FirebaseDatabase(databaseURL: _databaseURL);
    reference = _database!.reference().child('memo');

    reference!.onChildAdded.listen((event) {
      print(event.snapshot.value.toString());
      setState(() {
        memos.add(Memo.fromSnapshot(event.snapshot));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('메모 앱'),
      ),
      body: Container(
        child: Center(
          child: memos.isEmpty
              ? const CircularProgressIndicator()
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return Card(
                      child: GridTile(
                        child: Container(
                          padding: const EdgeInsets.only(top: 20, bottom: 20),
                          child: SizedBox(
                            child: GestureDetector(
                              // 상세보기 화면 이동
                              onTap: () async {
                                Memo? memo = await Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            MemoDetailPage(
                                                reference!, memos[index])));

                                if (memo != null) {
                                  setState(() {
                                    memos[index].title = memo.title;
                                    memos[index].title = memo.content;
                                  });
                                }
                              },
                              // 작성 메모 삭제
                              onLongPress: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: Text(memos[index].title),
                                          content: const Text("삭제 하시겠습니까?"),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  reference!
                                                      .child(memos[index].key!)
                                                      .remove()
                                                      .then((value) {
                                                    setState(() {
                                                      memos.removeAt(index);
                                                      Navigator.of(context)
                                                          .pop();
                                                    });
                                                  });
                                                },
                                                child: const Text("예")),
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text("아니오"))
                                          ],
                                        ));
                              },
                              child: Text(memos[index].content),
                            ),
                          ),
                        ),
                        header: Text(memos[index].title),
                        footer: Text(memos[index].createTime.substring(0, 10)),
                      ),
                    );
                  },
                  itemCount: memos.length,
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => MemoAddPage(reference!)));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
