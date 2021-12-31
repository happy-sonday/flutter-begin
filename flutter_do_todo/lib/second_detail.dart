import 'package:flutter/material.dart';

class SecondDetail extends StatelessWidget {
  TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Second Page"),
      ),
      body: Container(
        child: Center(
            child: Column(
          children: <Widget>[
            TextField(
              controller: controller,
              keyboardType: TextInputType.text,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(controller.value.text);
              },
              child: const Text("저장하기"),
            )
          ],
        )),
      ),
    );
  }
}
