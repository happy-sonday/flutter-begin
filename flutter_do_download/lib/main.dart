import 'package:flutter/material.dart';
import 'package:flutter_do_download/intro_page.dart';
import 'package:flutter_do_download/largefile_main.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IntroPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('서버로 부터 로고 바꾸기'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LargefileMain()));
              },
              child: const Text(
                "로고 바꾸기",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: Center(),
    );
  }
}
