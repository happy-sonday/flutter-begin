import 'package:flutter/material.dart';

class SecondDetail extends StatelessWidget {
  const SecondDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Second Page"),
      ),
      body: Container(
        child: Center(
          child: ElevatedButton(
            child: Text("세 번째 페이지로 가기"),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/third');
            },
          ),
        ),
      ),
    );
  }
}
