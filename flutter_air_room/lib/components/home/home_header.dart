import 'package:flutter/material.dart';
import 'package:flutter_air_room/components/home/home_header_appbar.dart';
import 'package:flutter_air_room/components/home/home_header_form.dart';
import 'package:flutter_air_room/size.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // context를 이용한 화면 width값을 가져와 미디어쿼리 적용
    double screenWidth = MediaQuery.of(context).size.width;
    return
        //padding: const EdgeInsets.only(top: gap_m),
        Align(
      alignment: screenWidth < 960 ? Alignment(0, 0) : Alignment(-0.6, 0),
      child: Container(
        width: double.infinity,
        height: header_height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/background.jpeg"),
                fit: BoxFit.cover)),
        child: Column(
          children: [HomeHeaderAppBar(), HomeHeaderForm()],
        ),
      ),
    );
  }
}
