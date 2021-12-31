import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class LargefileMain extends StatefulWidget {
  const LargefileMain({Key? key}) : super(key: key);

  @override
  _LargefileMainState createState() => _LargefileMainState();
}

class _LargefileMainState extends State<LargefileMain> {
  // final imgUrl =
  //     "https://images.pexels.com/photos/240040/pexels-photo-240040.jpeg?auto=compress";

  bool downloading = false;
  var progressingString = "";
  String file = "";
  TextEditingController? _editingController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _editingController = new TextEditingController(
        // 초기 구동 시 기본 입력값 설정
        text:
            "https://images.pexels.com/photos/240040/pexels-photo-240040.jpeg?auto=compress");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text("Large File Download"),
        title: TextField(
          controller: _editingController,
          style: TextStyle(color: Colors.white),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(hintText: 'url 입력하세요'),
        ),
      ),
      body: Center(
          child: downloading
              ? Container(
                  height: 120,
                  width: 200,
                  child: Card(
                    color: Colors.black,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircularProgressIndicator(),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          "Downloading File: $progressingString",
                          style: const TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                )
              // : FloatingActionButton(
              //     onPressed: () {
              //       downloadFile();
              //     },
              //     child: Icon(Icons.file_download),
              //   )),
              //NOTE: 아직 데이터가 없지만 데이터를 받아 처리한 후 만들 위젯
              // FutureBuilder는 builder에서 snapshot변수를 반환, dynamic FuterBuilder.future
              : FutureBuilder(
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        print("none");
                        return Text("데이터 없음");
                      case ConnectionState.waiting:
                        print("waiting");
                        return CircularProgressIndicator();
                      case ConnectionState.active:
                        print("active");
                        return CircularProgressIndicator();
                      case ConnectionState.done:
                        if (snapshot.hasData) {
                          return snapshot.data as Widget;
                        }
                    }

                    print("end Process");
                    return Text("데이터 없음");
                  },
                  future: downloadWidget(file),
                )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          downloadFile();
        },
        child: Icon(Icons.file_download),
      ),
    );
  }

  Future<Widget> downloadWidget(String filePath) async {
    File file = File(filePath);
    bool exist = await file.exists();

    // 캐시 초기화
    // NOTE: 빠른 이미지 처리를 위해 캐시에 같은 이름의 이미지가 있으면 이미지를 변경하지않고 해당 이미지를 재사용하기때문에
    // 같은 이름이여도 테스트 위해 같은 이름의 이미지를 다시 갱신
    FileImage(file).evict();

    if (exist) {
      return Center(
          child: Column(children: <Widget>[Image.file(File(filePath))]));
    } else {
      return const Text('No Data');
    }
  }

  Future<void> downloadFile() async {
    Dio dio = Dio();
    try {
      // NOTE: path_provider 패키지가 제공하느 함수
      // dio.download를 이용해 url에 담긴 주소에서 파일을 내려받고, 내부 디렉토리에 my.image.jpg이름으로 저장
      var dir = await getApplicationDocumentsDirectory();
      //await dio.download(imgUrl, "${dir.path}/myimage.jpg",
      await dio.download(
          _editingController!.value.text, "${dir.path}/myimage.jpg",

          /**
       * 데이터를 받을 때마다 onReceiveProgress함수를 실행해 진행 상황을 표시
       * rec : 지금까지대려받은 데이터
       * total : 파일의 전체 크기
       */
          onReceiveProgress: (rec, total) {
        print('Rec : ${rec}, Total: ${total}');
        file = "${dir.path}/myimage.jpg";
        setState(() {
          downloading = true;
          progressingString = ((rec / total) * 100).toStringAsFixed(0) + "%";
        });
      });
    } catch (e) {
      print(e);
    }

    setState(() {
      downloading = false;
      progressingString = 'Completed';
    });
    print("Download completed");
  }
}
