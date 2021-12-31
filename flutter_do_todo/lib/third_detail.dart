import 'package:flutter/material.dart';

class ThirdDetail extends StatelessWidget {
  const ThirdDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 전달받은 데이터 가져오기
    final String args = ModalRoute.of(context)!.settings.arguments.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text("Third Page"),
      ),
      body: Container(
        child: Center(
            child:
                // ElevatedButton(
                //   onPressed: () {
                //     Navigator.of(context).pop();
                //   },
                //   child: Text("첫 번째 페이지로 돌아기"),
                // ),
                Text(
          args,
          style: TextStyle(fontSize: 30),
        )),
      ),
    );
  }
}
