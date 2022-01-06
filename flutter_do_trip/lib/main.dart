import 'package:flutter/material.dart';
import 'package:flutter_do_trip/model/page/login_page.dart';
import 'package:flutter_do_trip/model/page/sign_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '손데이 트립',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // 라우트 등록
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/sign': (context) => const SignPage(),
      },
    );
  }
}
