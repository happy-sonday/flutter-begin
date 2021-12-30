import 'dart:collection';

import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(MyApp());
}

// class MyApp extends StatelessWidget {
//   MyApp({Key? key}) : super(key: key);
//   var switchValue = false;

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'flutter_do_first',
//       darkTheme: ThemeData.dark(),
//       home: Scaffold(
//         body: Center(
//           child: Switch(
//             onChanged: (value) {
//               switchValue = value;
//             },
//             value: switchValue,
//           ),
//         ),
//       ),
//     );
//   }
// }

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var switchValue = false;
  String test = "sonday";
  Color _color = Colors.pink;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter_do_first',
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        body: Center(
          child: ListView(
            children: [
              Switch(
                onChanged: (value) {
                  setState(() {
                    switchValue = value;
                  });
                },
                value: switchValue,
              ),
              ElevatedButton(
                onPressed: () {
                  if (test == 'sonday') {
                    setState(() {
                      test = 'happy';
                      _color = Colors.purple;
                    });
                  } else {
                    setState(() {
                      test = 'sonday';
                      _color = Colors.greenAccent;
                    });
                  }
                },
                child: Text("$test"),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(_color)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
