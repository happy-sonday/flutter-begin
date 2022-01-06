import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../user.dart';

class SignPage extends StatefulWidget {
  const SignPage({Key? key}) : super(key: key);

  @override
  _SignPageState createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  FirebaseDatabase? _database;
  DatabaseReference? reference;
  String _databaseUrl = "DB_URL";

  TextEditingController? _idTextController;
  TextEditingController? _pwTextController;
  TextEditingController? _pwCheckTextController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _idTextController = TextEditingController();
    _pwTextController = TextEditingController();
    _pwCheckTextController = TextEditingController();

    _database = FirebaseDatabase(databaseURL: _databaseUrl);
    reference = _database!.reference().child('user');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("회원가입"),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                child: TextField(
                  controller: _idTextController,
                  maxLines: 1,
                  decoration: const InputDecoration(
                      hintText: '4자 이상 입력해 주세요',
                      labelText: '아이디',
                      border: OutlineInputBorder()),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 200,
                child: TextField(
                  controller: _pwTextController,
                  obscureText: true,
                  maxLines: 1,
                  decoration: const InputDecoration(
                      hintText: '6자 이상 입력해주세요',
                      labelText: '비밀번호',
                      border: OutlineInputBorder()),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 200,
                child: TextField(
                  controller: _pwCheckTextController,
                  obscureText: true,
                  maxLines: 1,
                  decoration: const InputDecoration(
                      hintText: '비밀번호를 재확인하세요',
                      labelText: '비밀번호',
                      border: OutlineInputBorder()),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_idTextController!.value.text.length >= 4 &&
                      _pwTextController!.value.text.length >= 6) {
                    if (_pwTextController!.value.text ==
                        _pwCheckTextController!.value.text) {
                      var bytes = utf8.encode(_pwTextController!.value.text);
                      var digest = sha1.convert(bytes);
                      reference!
                          .child(_idTextController!.value.text)
                          .push()
                          .set(User(
                                  _idTextController!.value.text,
                                  digest.toString(),
                                  DateTime.now().toIso8601String())
                              .toJson())
                          .then((value) => Navigator.of(context).pop());
                    } else {
                      makeDialog('이렵하신 비밀번호가 틀립니다.');
                    }
                  } else {
                    makeDialog('길이가 짧습니다.');
                  }
                },
                child:
                    const Text("회원가입", style: TextStyle(color: Colors.white)),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.blueAccent)),
              )
            ],
          ),
        ),
      ),
    );
  }

  void makeDialog(String text) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(content: Text(text));
        });
  }
}
