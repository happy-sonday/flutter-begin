import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Logo extends StatelessWidget {
  final String title;

  const Logo({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SvgPicture.asset(
        "assets/instagram-1.svg",
        width: 200,
      ),
      Text(title,
          style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold))
    ]);
  }
}
