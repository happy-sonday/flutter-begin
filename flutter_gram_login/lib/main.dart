import 'package:flutter/material.dart';
import 'package:flutter_gram_login/pages/home_page.dart';
import 'package:flutter_gram_login/pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            textButtonTheme: TextButtonThemeData(
                style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.black),
          textStyle: MaterialStateProperty.all(
              const TextStyle(fontWeight: FontWeight.bold)),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
          minimumSize: MaterialStateProperty.all(const Size(400, 60)),
          foregroundColor: MaterialStateProperty.all(Colors.white),
        ))),
        debugShowCheckedModeBanner: false,
        initialRoute: "/login",
        routes: {
          "/login": (context) => LoginPage(),
          "/home": (context) => const HomePage(),
        });
  }
}
