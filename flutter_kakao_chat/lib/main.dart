import 'package:flutter/material.dart';
import 'package:flutter_kakao_chat/screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
        elevation: 0.0,
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 24),
        iconTheme: IconThemeData(color: Colors.black),
      )),
      home: MainScreen(),
    );
  }
}
