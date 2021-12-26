import 'package:flutter/material.dart';
import 'package:flutter_haplix/model/model_movie.dart';

class CircleSlider extends StatelessWidget {
  final List<Movie> movies;

  const CircleSlider({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("미리보기"),
          SizedBox(
            height: 120,
            child: ListView(
                scrollDirection: Axis.horizontal,
                children: makeCircleImages(movies)),
          )
        ],
      ),
    );
  }
}

List<Widget> makeCircleImages(List<Movie> movies) {
  List<Widget> results = [];
  for (var i = 0; i < movies.length; i++) {
    results.add(InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.only(right: 10),
        child: Align(
          alignment: Alignment.centerLeft,
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/' + movies[i].poster),
            radius: 50,
          ),
        ),
      ),
    ));
  }

  return results;
}
