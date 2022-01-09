import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  final DatabaseReference? databaseReference;
  final String? id;

  SettingPage({this.databaseReference, this.id});

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool pushCheck = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('설정하기'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                const Text(
                  '푸시 알림',
                  style: TextStyle(fontSize: 20),
                ),
                Switch(
                    value: pushCheck,
                    onChanged: (value) {
                      setState(() {
                        pushCheck = value;
                      });
                      _setData(value);
                    })
              ],
              mainAxisAlignment: MainAxisAlignment.spaceAround,
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {
                // 모든 스택을 비우고 홈화면으로 이동
                Navigator.of(context).pushNamedAndRemoveUntil(
                    "/", (Route<dynamic> route) => false);
              },
              child: const Text('로그아웃', style: TextStyle(fontSize: 20)),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {
                // 회원탈퇴시 실시간 데이터 베이스의 해당 데이터 삭제
                AlertDialog dialog = AlertDialog(
                  title: const Text('아이디 삭제'),
                  content: const Text('아이디를 삭제하시겠습니까?'),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () {
                          print(widget.id);
                          widget.databaseReference!
                              .child('user')
                              .child(widget.id!)
                              .remove();
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/', (Route<dynamic> route) => false);
                        },
                        child: const Text('예')),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('아니요')),
                  ],
                );
                showDialog(
                    context: context,
                    builder: (context) {
                      return dialog;
                    });
              },
              child: const Text('회원 탈퇴', style: TextStyle(fontSize: 20)),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
    ;
  }

  void _setData(bool value) async {
    var key = "push";
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(key, value);
  }

  void _loadData() async {
    var key = "push";
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      var value = pref.getBool(key);
      if (value == null) {
        setState(() {
          pushCheck = true;
        });
      } else {
        setState(() {
          pushCheck = value;
        });
      }
    });
  }
}
