import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 공유환경설정에 저장된 값 가져옴
    _loadData();
  }

  // 데이터를 저장하는 함수
  void _setData(int value) async {
    var key = 'count';
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt(key, value);
  }

  // 데이터를 가져오는 함수
  void _loadData() async {
    var key = 'count';
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      var value = pref.getInt(key);
      if (value == null) {
        _counter = 0;
      } else {
        _counter = value;
      }
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      //해당 함수 호출할때, 동시에 _setData함수를 통해 공유환경에 데이터 저장
      _setData(_counter);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
