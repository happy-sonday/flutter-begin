import 'package:flutter/material.dart';
import 'package:flutter_do_trip/model/page/login_page.dart';
import 'package:flutter_do_trip/model/page/main_page.dart';
import 'package:flutter_do_trip/model/page/sign_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
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
        '/main': (context) => const MainPage(),
      },
    );
  }
}
