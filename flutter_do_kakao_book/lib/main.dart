import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  String result = '';
  List? data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = new List.empty(growable: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('http Example'),
      ),
      body: Container(
          child: Center(
              child: data!.length == 0
                  ? const Text(
                      "데이터가 없습니다",
                      style: TextStyle(fontSize: 25),
                      textAlign: TextAlign.center,
                    )
                  : ListView.builder(itemBuilder: (context, index) {
                      return Card(
                        child: Container(
                          child: Row(
                            children: <Widget>[
                              Image.network(
                                data![index]['thumbnail'],
                                height: 100,
                                width: 100,
                                fit: BoxFit.contain,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width - 150,
                                    child: Text(
                                      data![index]['title'].toString(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Text(data![index]['authors'].toString()),
                                  Text(data![index]['sela_price'].toString()),
                                  Text(data![index]['status'].toString()),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }))),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //var url = 'http://www.google.com';
          //var response = await http.get(Uri.parse(url));
          // setState(() {
          //   result = response.body;
          // });

          getJSONData();
        },
        child: const Icon(Icons.file_download),
      ),
    );
  }

  Future<String> getJSONData() async {
    var url = 'https://dapi.kakao.com/v3/search/book?target=title&query=doit';

    var response = await http.get(Uri.parse(url),
        headers: {"Authorization": "KakaoAK c92aeac4517ba2450195e64d551e2c72"});

    //print(response.body); // 검색 결과 로그창으로 확인
    setState(() {
      var dataConvertedToJSON = json.decode(response.body);
      List result = dataConvertedToJSON['documents'];
      data!.addAll(result);
    });

    return response.body;
  }
}
