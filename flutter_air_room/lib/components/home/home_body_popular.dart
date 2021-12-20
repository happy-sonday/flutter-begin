import 'package:flutter/material.dart';
import 'package:flutter_air_room/components/home/home_popular_item.dart';
import 'package:flutter_air_room/size.dart';
import 'package:flutter_air_room/styles.dart';

class HomeBodyPopular extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: gap_m),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPopulartitle(),
          _buildPopularList(),
        ],
      ),
    );
  }

  Widget _buildPopulartitle() {
    return Column(
      children: [
        Text(
          "한국 숙소에 직접 다년간 게스트의 후기",
          style: h5(),
        ),
        Text(
          "게스트 후기 2,500,000개 이상, 평균 평점 4.7점 (5점 만점)",
          style: body1(),
        ),
        const SizedBox(
          height: gap_m,
        )
      ],
    );
  }

  Widget _buildPopularList() {
    return Wrap(
      children: [
        HomeBodyPopularItem(id: 0),
        const SizedBox(width: 7.5),
        HomeBodyPopularItem(id: 1),
        const SizedBox(width: 7.5),
        HomeBodyPopularItem(id: 2),
      ],
    );
  }
}
