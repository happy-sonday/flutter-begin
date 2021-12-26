import 'package:flutter/material.dart';
import 'package:flutter_haplix/model/model_movie.dart';

class BoxSlider extends StatelessWidget {
  final List<Movie> movies;
  const BoxSlider({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("지금 뜨는 콘텐츠"),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: makeBoxImages(movies),
            ),
          )
        ],
      ),
    );
  }
}

List<Widget> makeBoxImages(List<Movie> movies) {
  List<Widget> results = [];
  for (var i = 0; i < movies.length; i++) {
    results.add(InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.only(right: 10),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Image.asset('assets/' + movies[i].poster)),
      ),
    ));
  }

  return results;
}
