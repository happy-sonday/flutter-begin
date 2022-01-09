import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_do_trip/model/area.dart';
import 'package:flutter_do_trip/model/item.dart';
import 'package:flutter_do_trip/model/kind.dart';
import 'package:flutter_do_trip/model/tour.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'package:sqflite/sqflite.dart';

import 'tour_detail_page.dart';

class MapPage extends StatefulWidget {
  final DatabaseReference? databaseReference; // 실시간 데이터베이스 변수
  final Future<Database>? db; // 내부에 저장되는 데이터베이스
  final String? id; // 로그인한 아이디
  MapPage({this.databaseReference, this.db, this.id});

  @override
  State<StatefulWidget> createState() => _MapPage();
}

class _MapPage extends State<MapPage> {
  List<DropdownMenuItem<Item>> list = List.empty(growable: true);
  List<DropdownMenuItem<Item>> sublist = List.empty(growable: true);
  List<Tour> tourData = List.empty(growable: true);
  ScrollController? _scrollController;
  String? authKey = dotenv.env['TRIP_TRIP_API_KR'];
  Item? area;
  Item? kind;
  int page = 1;

  @override
  void initState() {
    super.initState();
    list = Area().seoulArea;
    sublist = Kind().kinds;
    area = list[0].value;
    kind = sublist[0].value;
    _scrollController = ScrollController();
    _scrollController!.addListener(() {
      if (_scrollController!.offset >=
              _scrollController!.position.maxScrollExtent &&
          !_scrollController!.position.outOfRange) {
        page++;
        getAreaList(area: area!.value, contentTypeId: kind!.value, page: page);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('검색하기'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                DropdownButton<Item>(
                  items: list,
                  onChanged: (value) {
                    Item selectedItem = value as Item;
                    setState(() {
                      area = selectedItem;
                    });
                  },
                  value: area,
                ),
                const SizedBox(
                  width: 10,
                ),
                DropdownButton<Item>(
                  items: sublist,
                  onChanged: (value) {
                    Item selectedItem = value as Item;
                    setState(() {
                      kind = selectedItem;
                    });
                  },
                  value: kind,
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    page = 1;
                    tourData.clear();
                    getAreaList(
                        area: area!.value,
                        contentTypeId: kind!.value,
                        page: page);
                  },
                  child: const Text(
                    '검색하기',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blueAccent)),
                )
              ],
              mainAxisAlignment: MainAxisAlignment.spaceAround,
            ),
            Expanded(
                child: ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  child: InkWell(
                    child: Row(
                      children: <Widget>[
                        Hero(
                            tag: 'tourinfo$index',
                            child: Container(
                                margin: const EdgeInsets.all(10),
                                width: 100.0,
                                height: 100.0,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.black, width: 1),
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: getImage(
                                            tourData[index].imagePath))))),
                        const SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          child: Column(
                            children: <Widget>[
                              Text(
                                tourData[index].title!,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text('주소 : ${tourData[index].address}'),
                              tourData[index].tel != null
                                  ? Text('전화 번호 : ${tourData[index].tel}')
                                  : Container(),
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          ),
                          width: MediaQuery.of(context).size.width - 150,
                        )
                      ],
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => TourDetailPage(
                                id: widget.id,
                                tour: tourData[index],
                                index: index,
                                databaseReference: widget.databaseReference,
                              )));
                    },
                    onDoubleTap: () {},
                  ),
                );
              },
              itemCount: tourData.length,
              controller: _scrollController,
            ))
          ],
          mainAxisAlignment: MainAxisAlignment.start,
        ),
      ),
    );
  }

  ImageProvider getImage(String? imagePath) {
    if (imagePath != null) {
      return NetworkImage(imagePath);
    } else {
      //return const AssetImage('assets/img/map_location.png');
      return const AssetImage('assets/img/map_location.png');
    }
  }

  void getAreaList(
      {required int area,
      required int contentTypeId,
      required int page}) async {
    var url =
        'http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList?serviceKey=$authKey&pageNo=$page&numOfRows=20&MobileApp=SondyTrip&MobileOS=ETC&areaCode=1&sigunguCode=$area&_type=json';
    if (contentTypeId != 0) {
      url = url + '&contentTypeId=$contentTypeId';
    }
    var response = await http.get(Uri.parse(url));
    String body = utf8.decode(response.bodyBytes);

    var json = jsonDecode(body);
    if (json['response']['header']['resultCode'] == "0000") {
      if (json['response']['body']['items'] == '') {
        showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                content: Text('마지막 데이터 입니다'),
              );
            });
      } else {
        print(json['response']['body']['items']['item']);
        List jsonArray = json['response']['body']['items']['item'];

        for (var s in jsonArray) {
          setState(() {
            tourData.add(Tour.fromJson(s));
          });
        }
      }
    } else {
      print('error');
    }
  }
}
