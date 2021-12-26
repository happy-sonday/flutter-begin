import 'package:flutter/material.dart';
import 'package:flutter_haplix/model/model_movie.dart';
import 'package:flutter_haplix/widget/box_slider.dart';
import 'package:flutter_haplix/widget/carousel_slider.dart';
import 'package:flutter_haplix/widget/circle_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Movie> movies = [
    Movie.fromMap({
      'title': '그해 우리는',
      'keyword': '사랑/청춘/로맨스',
      'poster': 'we_were.jpg',
      'like': false,
    }),
    Movie.fromMap({
      'title': '그해 우리는',
      'keyword': '사랑/청춘/로맨스',
      'poster': 'we_were.jpg',
      'like': false,
    }),
    Movie.fromMap({
      'title': '그해 우리는',
      'keyword': '사랑/청춘/로맨스',
      'poster': 'we_were.jpg',
      'like': false,
    }),
    Movie.fromMap({
      'title': '그해 우리는',
      'keyword': '사랑/청춘/로맨스',
      'poster': 'we_were.jpg',
      'like': false,
    }),
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   child: Center(
    //     child: Text("real home"),
    //   ),
    // );
    return ListView(
      children: [
        // 스택원리로 제일 먼저 오는게 제일 마지막에 위치해야 한다.
        Stack(
          children: [
            CarouselImage(
              movies: movies,
            ),
            const TopBar(),
          ],
        ),
        CircleSlider(movies: movies),
        BoxSlider(movies: movies)
      ],
    );
  }
}

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 7, 20, 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset('assets/netflix_logo.png',
              fit: BoxFit.contain, height: 25),
          Container(
            padding: const EdgeInsets.only(right: 1),
            child: const Text(
              "TV 프로그램",
              style: TextStyle(fontSize: 14),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(right: 1),
            child: const Text(
              "영화",
              style: TextStyle(fontSize: 14),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(right: 1),
            child: const Text(
              "내가 찜한 콘텐츠",
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
