import 'package:flutter/material.dart';
import 'package:flutter_air_room/constants.dart';
import 'package:flutter_air_room/size.dart';
import 'package:flutter_air_room/styles.dart';

class HomeHeaderAppBar extends StatelessWidget {
  const HomeHeaderAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(gap_m),
      child: Row(
        children: [_bulidAppBarLogo(), const Spacer(), _bulidAppBarMenu()],
      ),
    );
  }

  Widget _bulidAppBarLogo() {
    return Row(
      children: [
        Image.asset(
          "assets/logo.png",
          width: 30,
          height: 30,
          color: kAccentColor,
        ),
        const SizedBox(
          width: gap_s,
        ),
        Text(
          "AirRoom",
          style: h5(mColor: Colors.white),
        )
      ],
    );
  }

  Widget _bulidAppBarMenu() {
    return Row(
      children: [
        Text(
          "회원가입",
          style: subtitle(mColor: Colors.white),
        ),
        const SizedBox(
          width: gap_s,
        ),
        Text(
          "로그인",
          style: subtitle(mColor: Colors.white),
        )
      ],
    );
  }
}
