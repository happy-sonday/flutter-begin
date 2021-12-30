import 'package:flutter/material.dart';

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
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const widgetApp(),
    );
  }
}

class widgetApp extends StatefulWidget {
  const widgetApp({Key? key}) : super(key: key);

  @override
  _widgetAppState createState() => _widgetAppState();
}

class _widgetAppState extends State<widgetApp> {
  String sum = "";
  TextEditingController value1 = TextEditingController();
  TextEditingController value2 = TextEditingController();

  final List _buttonList = ['더하기', '빼기', '곱하기', '나누기'];
  final List<DropdownMenuItem<String>> _dropDownMenItems =
      List.empty(growable: true);

  String? _buttonText;

  @override
  void initState() {
    super.initState();
    for (var item in _buttonList) {
      _dropDownMenItems.add(DropdownMenuItem(
        value: item,
        child: Text(item),
      ));
    }
    _buttonText = _dropDownMenItems[0].value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Widget Example"),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  "결과 $sum",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: value1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: value2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ElevatedButton(
                  //사용자 입력값 가져와 결과값 update

                  onPressed: () {
                    setState(() {
                      var value1Int = double.parse(value1.value.text);
                      var value2Int = double.parse(value2.value.text);
                      var result;

                      if (_buttonText == '더하기') {
                        result = value1Int + value2Int;
                      } else if (_buttonText == '빼기') {
                        result = value1Int - value2Int;
                      } else if (_buttonText == '곱하기') {
                        result = value1Int * value2Int;
                      } else {
                        result = value1Int / value2Int;
                      }

                      sum = '$result';
                    });
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(buttonIcon(_buttonText!)),
                      Text(_buttonText!)
                    ],
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.amber)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: DropdownButton(
                  items: _dropDownMenItems,
                  onChanged: (String? value) {
                    setState(() {
                      _buttonText = value;
                    });
                  },
                  value: _buttonText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData buttonIcon(String text) {
    if (text == '더하기') {
      return Icons.add;
    } else if (text == '빼기') {
      return Icons.remove;
    } else if (text == '곱하기') {
      return Icons.clear;
    }

    return Icons.splitscreen_outlined;
  }
}
