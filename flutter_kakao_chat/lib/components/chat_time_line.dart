import 'package:flutter/material.dart';

class ChatTimeLine extends StatelessWidget {
  const ChatTimeLine({Key? key, required this.time}) : super(key: key);

  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Color(0xFFcafbe)),
      child: Text(
        time,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
