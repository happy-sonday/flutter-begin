import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_do_trip/model/tour.dart';
import 'package:flutter_do_trip/page/tour_detail_page.dart';
import 'package:sqflite/sqflite.dart';

class FavoritePage extends StatefulWidget {
  final DatabaseReference? databaseReference;
  final Future<Database>? db;
  final String? id;

  FavoritePage({this.databaseReference, this.db, this.id});

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  Future<List<Tour>>? _tourList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tourList = getTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('즐겨찾기'),
      ),
      body: Center(
        child: FutureBuilder(
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const CircularProgressIndicator();
              case ConnectionState.waiting:
                return const CircularProgressIndicator();
              case ConnectionState.active:
                return const CircularProgressIndicator();
              case ConnectionState.done:
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      List<Tour> tourList = snapshot.data as List<Tour>;
                      Tour info = tourList[index];
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
                                              image:
                                                  getImage(info.imagePath!))))),
                              const SizedBox(
                                width: 20,
                              ),
                              Container(
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      info.title!,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text('주소 : ${info.address}'),
                                    info.tel != '확인중'
                                        ? Text('전화 번호 : ${info.tel}')
                                        : Container(),
                                  ],
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                ),
                                width: MediaQuery.of(context).size.width - 150,
                              )
                            ],
                          ),
                          onTap: () {
                            // 상세페이지 이동은
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => TourDetailPage(
                                      id: widget.id,
                                      tour: info,
                                      index: index,
                                      databaseReference:
                                          widget.databaseReference,
                                    )));
                          },
                          // 즐겨찾기 목록에서 삭제
                          onDoubleTap: () {
                            deleteTour(widget.db!, info);
                          },
                        ),
                      );
                    },
                    itemCount: (snapshot.data! as List<Tour>).length,
                  );
                } else {
                  return const Text('No data');
                }
            }
          },
          future: _tourList,
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

  Future<List<Tour>> getTodos() async {
    final Database? database = await widget.db;
    final List<Map<String, dynamic>> maps = await database!.query('place');

    return List.generate(maps.length, (i) {
      return Tour(
          title: maps[i]['title'].toString(),
          tel: maps[i]['tel'].toString(),
          address: maps[i]['address'].toString(),
          zipcode: maps[i]['zipcode'].toString(),
          mapy: maps[i]['mapy'].toString(),
          mapx: maps[i]['mapx'].toString(),
          imagePath: maps[i]['imagePath'].toString());
    });
  }

  void deleteTour(Future<Database> db, Tour info) async {
    final Database database = await db;
    await database.delete('place',
        where: 'title=?', whereArgs: [info.title]).then((value) {
      setState(() {
        _tourList = getTodos();
      });
      Scaffold.of(context)
          .showSnackBar(const SnackBar(content: Text('즐겨찾기를 해제합니다')));
    });
  }
}
