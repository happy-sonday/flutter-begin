import 'dart:async';
import 'dart:convert';

import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_do_trip/model/user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  FirebaseDatabase? _database;
  DatabaseReference? reference;
  String _databaseUrl = "DB_URL";

  double opacity = 0;
  AnimationController? _animationController;
  Animation? _animation;
  TextEditingController? _idTextController;
  TextEditingController? _pwTextController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _idTextController = TextEditingController();
    _pwTextController = TextEditingController();

    // NOTE: with SingleTickerProviderStateMixin 상속
    _animationController =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    _animation =
        Tween<double>(begin: 0, end: pi * 2).animate(_animationController!);
    _animationController!.repeat();
    Timer(Duration(seconds: 2), () {
      setState(() {
        opacity = 1;
      });
    });

    _database = FirebaseDatabase(databaseURL: _databaseUrl);
    reference = _database!.reference().child('user');
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                  animation: _animationController!,
                  builder: (context, widget) {
                    return Transform.rotate(
                      angle: _animation!.value,
                      child: widget,
                    );
                  },
                  child: const Icon(
                    Icons.airplanemode_active,
                    color: Colors.deepOrangeAccent,
                    size: 80,
                  )),
              const SizedBox(
                  height: 100,
                  child: Center(
                    child: Text(
                      "Sonday Trip",
                      style: TextStyle(fontSize: 30),
                    ),
                  )),
              AnimatedOpacity(
                opacity: opacity,
                duration: const Duration(seconds: 1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 200,
                      child: TextField(
                        controller: _idTextController,
                        maxLines: 1,
                        decoration: const InputDecoration(
                            labelText: '아이디', border: OutlineInputBorder()),
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
                            labelText: '비밀번호', border: OutlineInputBorder()),
                      ),
                    ),

                    // 회원가입과 로그인 버튼을 누르고 이동할 경로 등록
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('/sign');
                            },
                            child: const Text("회원가입")),
                        TextButton(
                            onPressed: () {
                              if (_idTextController!.value.text.isEmpty ||
                                  _pwTextController!.value.text.isEmpty) {
                                Navigator.of(context).pushNamed('/login');
                              } else {
                                reference!
                                    .child(_idTextController!.value.text)
                                    .onValue
                                    .listen((event) {
                                  if (event.snapshot.value == null) {
                                    makeDialog("아이디를 확인해 주세요");
                                  } else {
                                    reference!
                                        .child(_idTextController!.value.text)
                                        .onChildAdded
                                        .listen((event) {
                                      User user =
                                          User.fromSnapshot(event.snapshot);

                                      // NOTE: 비밀번호ㅓ utf8로 인코딩후 해시 알고리즘으로 적용하여 보안강화
                                      var bytes = utf8.encode(
                                          _pwTextController!.value.text);
                                      var digest = sha1.convert(bytes);

                                      if (user.pw == digest.toString()) {
                                        Navigator.of(context)
                                            .pushReplacementNamed('/main',
                                                arguments: _idTextController!
                                                    .value.text);
                                      } else {
                                        makeDialog('비밀번호를 확인해 주세요.');
                                      }
                                    });
                                  }
                                });
                              }
                            },
                            child: const Text("로그인")),
                      ],
                    )
                  ],
                ),
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
          return AlertDialog(
            content: Text(text),
          );
        });
  }
}
