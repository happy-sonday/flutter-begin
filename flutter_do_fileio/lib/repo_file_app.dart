import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RepoFileApp extends StatefulWidget {
  const RepoFileApp({Key? key}) : super(key: key);

  @override
  _RepoFileAppState createState() => _RepoFileAppState();
}

class _RepoFileAppState extends State<RepoFileApp> {
  int _count = 0;
  List<String> itemList = new List.empty(growable: true);
  TextEditingController controller = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readContFile();
    initData();
  }

  void initData() async {
    var result = await readListFile();
    setState(() {
      itemList.addAll(result);
    });
  }

  Future<List<String>> readListFile() async {
    List<String> itemList = new List.empty(growable: true);
    // 공유 환경설정에 파일을 처음 열었는지 확인하는 플래그
    var key = 'first';
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool? firstCheck = pref.getBool(key);

    //내부 저장소에 파일이 있는지 확인
    var dir = await getApplicationDocumentsDirectory();
    bool fileExist = await File(dir.path + '/drama.txt').exists();

    // 처음 열거나 없으면 공유 환경 설정에 true값과 함께 repo에 있는 파일을 읽어 내부저장소에 똑같은 파일을 복사 생성
    if (firstCheck == null || firstCheck == false || fileExist == false) {
      pref.setBool(key, true);
      var file =
          await DefaultAssetBundle.of(context).loadString('repo/drama.txt');

      File(dir.path + '/drama.txt').writeAsStringSync(file);
      var array = file.split('\n');
      for (var item in array) {
        print(item);
        itemList.add(item);
      }
      return itemList;
    } else {
      // 아니라면 내부 저장소에 저장된 파일을 읽어서 동작
      var file = await File(dir.path + '/drama.txt').readAsStringSync();
      var array = file.split('\n');
      for (var item in array) {
        print(item);
        itemList.add(item);
      }
      return itemList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('File Example'),
      ),
      body: Container(
        child: Center(
            child: Column(
          children: [
            TextField(
              controller: controller,
              keyboardType: TextInputType.text,
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                      child: Center(
                    child: Text(
                      itemList[index],
                      style: TextStyle(fontSize: 30),
                    ),
                  ));
                },
                itemCount: itemList.length,
              ),
            )
          ],
        )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
