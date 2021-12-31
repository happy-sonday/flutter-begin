import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class FileApp extends StatefulWidget {
  const FileApp({Key? key}) : super(key: key);

  @override
  _FileAppState createState() => _FileAppState();
}

class _FileAppState extends State<FileApp> {
  int _count = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readContFile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('File Example'),
      ),
      body: Container(
        child: Center(
          child: Text(
            '$_count',
            style: const TextStyle(fontSize: 40),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _count++;
          });
          writeConutFile(_count);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void writeConutFile(int count) async {
    var dir = await getApplicationDocumentsDirectory();
    print(dir.path);
    File(dir.path + '/count.txt').writeAsStringSync(count.toString());
  }

  void readContFile() async {
    try {
      // NOTE: path_provider 패키지에 들어있는 함수
      // 내부 저장소의 경로를 가져와서 그곳에 파일을 읽거나 작성
      // await getTemporaryDirectory() 함수는 임시저장(캐시)해두었다가 앱이 종료되소 일정시간이 지나면 사라짐
      var dir = await getApplicationDocumentsDirectory();

      var file = await File(dir.path + '/count.txt').readAsString();
      print(file);
      setState(() {
        _count = int.parse(file);
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
