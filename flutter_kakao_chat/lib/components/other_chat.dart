import 'package:flutter/material.dart';
import 'package:flutter_kakao_chat/models/user.dart';

class OtherChat extends StatelessWidget {
  const OtherChat(
      {Key? key, required this.text, required this.time, required this.name})
      : super(key: key);
  final String name;
  final String text;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(friends[4].backgroundImage),
          ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name),
              Container(
                child: Text(text),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    color: Colors.white),
              )
            ],
          )),
          const SizedBox(width: 5),
          Text(
            time,
            style: const TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }
}
