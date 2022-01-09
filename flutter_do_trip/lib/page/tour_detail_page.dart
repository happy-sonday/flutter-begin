import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_do_trip/model/disable_info.dart';
import 'package:flutter_do_trip/model/review.dart';
import 'package:flutter_do_trip/model/tour.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math' as math;

class TourDetailPage extends StatefulWidget {
  final Tour? tour;
  final int? index;
  final DatabaseReference? databaseReference;
  final String? id;

  TourDetailPage({
    this.tour,
    this.index,
    this.databaseReference,
    this.id,
  });

  @override
  _TourDetailPageState createState() => _TourDetailPageState();
}

class _TourDetailPageState extends State<TourDetailPage> {
  Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  CameraPosition? _googleMapCamera;
  TextEditingController? _reviewTextController;
  Marker? marker;
  List<Review> reviews = List.empty(growable: true);
  bool _disableWidget = false;
  DisableInfo? _disableInfo;
  double disableCheck1 = 0;
  double disableCheck2 = 0;

  @override
  void initState() {
    super.initState();
    widget.databaseReference!
        .child('tour')
        .child(widget.tour!.id.toString())
        .child('review')
        .onChildAdded
        .listen((event) {
      if (event.snapshot.value != null) {
        setState(() {
          reviews.add(Review.fromSnapshot(event.snapshot));
        });
      }
    });

    _reviewTextController = TextEditingController();

    // 지도에 관광지 위경도를 설정
    _googleMapCamera = CameraPosition(
      target: LatLng(double.parse(widget.tour!.mapy.toString()),
          double.parse(widget.tour!.mapx.toString())),
      zoom: 16,
    );

    // 마커를 설정
    MarkerId markerId = MarkerId(widget.tour.hashCode.toString());
    marker = Marker(
        position: LatLng(double.parse(widget.tour!.mapy.toString()),
            double.parse(widget.tour!.mapx.toString())),
        flat: true,
        markerId: markerId);
    markers[markerId] = marker!;
    getDisableInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 150,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                '${widget.tour!.title}',
                style: const TextStyle(color: Colors.white, fontSize: 40),
              ),
              centerTitle: true,
              titlePadding: const EdgeInsets.only(top: 10),
            ),
            pinned: true,
            backgroundColor: Colors.deepOrangeAccent,
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Column(
                children: <Widget>[
                  Hero(
                      tag: 'tourinfo${widget.index}',
                      child: Container(
                          width: 300.0,
                          height: 300.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black, width: 1),
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: getImage(widget.tour!.imagePath))))),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Text(
                      widget.tour!.address!,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  getGoogleMap(),
                  _disableWidget == false
                      ? setDisableWidget()
                      : showDisableWidget(),
                  //  reviewWidget()
                ],
              ),
            ),
          ])),
          SliverPersistentHeader(
            delegate: _HeaderDelegate(
                minHeight: 50,
                maxHeight: 100,
                child: Container(
                  color: Colors.lightBlueAccent,
                  child: Center(
                    child: Column(
                      children: const <Widget>[
                        Text(
                          '후기',
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ),
                )),
            pinned: true,
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
            return Card(
              child: InkWell(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
                  child: Text(
                    '${reviews[index].id} : ${reviews[index].review}',
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
                onDoubleTap: () {
                  if (reviews[index].id == widget.id) {
                    widget.databaseReference!
                        .child('tour')
                        .child(widget.tour!.id.toString())
                        .child('review')
                        .child(widget.id!)
                        .remove();
                    setState(() {
                      reviews.removeAt(index);
                    });
                  }
                },
              ),
            );
          }, childCount: reviews.length)),
          SliverList(
              delegate: SliverChildListDelegate([
            ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('후기 쓰기'),
                        content: TextField(
                          controller: _reviewTextController,
                        ),
                        actions: <Widget>[
                          TextButton(
                              onPressed: () {
                                Review review = Review(
                                    widget.id!,
                                    _reviewTextController!.value.text,
                                    DateTime.now().toIso8601String());
                                widget.databaseReference!
                                    .child('tour')
                                    .child(widget.tour!.id.toString())
                                    .child('review')
                                    .child(widget.id!)
                                    .set(review.toJson());
                                Navigator.of(context).pop();
                              },
                              child: const Text('후기 쓰기')),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('종료하기')),
                        ],
                      );
                    });
              },
              child: const Text('댓글 쓰기'),
            )
          ]))
        ],
      ),
    );
  }

  getDisableInfo() {
    widget.databaseReference!
        .child('tour')
        .child(widget.tour!.id.toString())
        .onValue
        .listen((event) {
      _disableInfo = DisableInfo.fromSnapshot(event.snapshot);
      if (_disableInfo?.id == null) {
        setState(() {
          _disableWidget = false;
        });
      } else {
        setState(() {
          _disableWidget = true;
        });
      }
    });
  }

  ImageProvider getImage(String? imagePath) {
    if (imagePath != null) {
      return NetworkImage(imagePath);
    } else {
      return const AssetImage('assets/img/map_location.png');
    }
  }

  getGoogleMap() {
    return SizedBox(
      height: 400,
      width: MediaQuery.of(context).size.width - 50,

      // 지도를 표시하는 함수
      child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _googleMapCamera!,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: Set<Marker>.of(markers.values)),
    );
  }

  Widget setDisableWidget() {
    return Center(
      child: Column(
        children: <Widget>[
          const Text('데이터가 없습니다. 추가해주세요'),
          Text('시각 장애인 이용 점수 :  ${disableCheck1.floor()}'),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Slider(
                value: disableCheck1,
                min: 0,
                max: 10,
                onChanged: (value) {
                  setState(() {
                    disableCheck1 = value;
                  });
                }),
          ),
          Text('지체 장애인 이용 점수 : ${disableCheck2.floor()}'),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Slider(
                value: disableCheck2,
                min: 0,
                max: 10,
                onChanged: (value) {
                  setState(() {
                    disableCheck2 = value;
                  });
                }),
          ),
          ElevatedButton(
            onPressed: () {
              DisableInfo info = DisableInfo(widget.id, disableCheck1.floor(),
                  disableCheck2.floor(), DateTime.now().toIso8601String());
              widget.databaseReference!
                  .child("tour")
                  .child(widget.tour!.id.toString())
                  .set(info.toJson())
                  .then((value) {
                setState(() {
                  _disableWidget = true;
                });
              });
            },
            child: const Text('데이터 저장하기'),
          )
        ],
      ),
    );
  }

  showDisableWidget() {
    return Center(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.accessible, size: 40, color: Colors.orange),
              Text(
                '지체 장애 이용 점수 : ${_disableInfo!.disable2}',
                style: const TextStyle(fontSize: 20),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: <Widget>[
              const Icon(
                Icons.remove_red_eye,
                size: 40,
                color: Colors.orange,
              ),
              Text('시각 장애 이용 점수 : ${_disableInfo!.disable1}',
                  style: const TextStyle(fontSize: 20))
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
          const SizedBox(
            height: 20,
          ),
          Text('작성자  : ${_disableInfo!.id}'),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _disableWidget = false;
              });
            },
            child: const Text('새로 작성하기'),
          )
        ],
      ),
    );
  }
}

class _HeaderDelegate extends SliverPersistentHeaderDelegate {
  final double? minHeight;
  final double? maxHeight;
  final Widget? child;

  _HeaderDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => math.max(maxHeight!, minHeight!);

  @override
  double get minExtent => minHeight!;

  @override
  bool shouldRebuild(_HeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
