import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_do_native/native_app.dart';

import 'cupertino_native_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // NOTE: dart:io 에서 제공해주는 Platform 객체를 이용해 운영체제 확인가능
    if (Platform.isIOS) {
      return const CupertinoApp(
        home: CupertinoNativeApp(),
      );
    } else {
      return MaterialApp(
        title: 'Flutter Native API',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const NativeApp(),
      );
    }
  }
}
