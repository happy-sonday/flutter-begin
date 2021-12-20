import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_air_room/constants.dart';
import 'package:flutter_air_room/size.dart';
import 'package:flutter_air_room/styles.dart';

class HomeBodyPopularItem extends StatelessWidget {
  final id;
  final popularList = [
    "p1.jpeg",
    "p2.jpeg",
    "p3.jpeg",
  ];

  HomeBodyPopularItem({required this.id});

  @override
  Widget build(BuildContext context) {
    //NOTE: 인기아이템은 전체화면의 70%의 1/3만큼의 사이즈의 05 코기를 가진다.
    double popularItemWith = getBodyWidth(context) / 3 - 5;
    return Padding(
      padding: const EdgeInsets.only(top: gap_x1),
      child: Container(
        constraints: BoxConstraints(minWidth: 320),
        child: SizedBox(
          width: popularItemWith,
          child: Column(
            children: [
              _buildPopularItemImage(),
              _buildPopularItemStar(),
              _buildPopularItemComment(),
              _buildPopularItemUseInfo()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPopularItemImage() {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            "assets/${popularList[id]}",
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          height: gap_s,
        )
      ],
    );
  }

  Widget _buildPopularItemStar() {
    return Column(
      children: [
        Row(
          children: const [
            Icon(
              Icons.star,
              color: kAccentColor,
            ),
            Icon(
              Icons.star,
              color: kAccentColor,
            ),
            Icon(
              Icons.star,
              color: kAccentColor,
            ),
            Icon(
              Icons.star,
              color: kAccentColor,
            ),
            Icon(
              Icons.star,
              color: kAccentColor,
            ),
          ],
        ),
        SizedBox(
          height: gap_s,
        )
      ],
    );
  }

  Widget _buildPopularItemComment() {
    return Column(
      children: [
        Text(
          "깔끔하고 다 갖춰져있어서 좋았어요:) 위치도 완전 좋아요 다들 여기에 살고 싶다곸ㅋㅋㅋ화장실도 3개에요!! 5명이서 씻는것도 전혀 불편함이 없이 좋았어요",
          style: body1(),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(
          height: gap_s,
        )
      ],
    );
  }

  Widget _buildPopularItemUseInfo() {
    return Row(
      children: [
        const CircleAvatar(
          backgroundImage: AssetImage("assets/p1.jpeg"),
        ),
        const SizedBox(width: gap_s),
        Column(
          children: [
            Text(
              "데어",
              style: subtitle(),
            ),
            const Text("한국")
          ],
        )
      ],
    );
  }
}
