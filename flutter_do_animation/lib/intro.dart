import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_do_animation/animation_app.dart';
import 'package:flutter_do_animation/saturn-loading.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  Future<Timer> loadData() async {
    return Timer(const Duration(seconds: 20), onDoneloading);
  }

  onDoneloading() async {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const AnimationApp()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            children: [
              const Text("애니메이션 앱"),
              const SizedBox(
                height: 20,
              ),
              SaturnLoading()
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
    );
  }
}
