import 'package:flutter/material.dart';
import 'package:flutter_do_native/native_app.dart';

class CupertinoNativeApp extends StatefulWidget {
  const CupertinoNativeApp({Key? key}) : super(key: key);

  @override
  _CupertinoNativeAppState createState() => _CupertinoNativeAppState();
}

class _CupertinoNativeAppState extends State<CupertinoNativeApp> {
  @override
  Widget build(BuildContext context) {
    return const NativeApp();
  }
}
