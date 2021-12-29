import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 50),
          child: const CircleAvatar(
            radius: 100,
            backgroundImage: AssetImage('assets/netflix_logo.png'),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 3),
          decoration: const BoxDecoration(
              border: Border(
            bottom: BorderSide(color: Colors.red, width: 5),
          )),
          child: const Text("happy-sonday",
              style: TextStyle(fontSize: 25, color: Colors.white)),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: Linkify(
            onOpen: (link) async {
              if (await canLaunch(link.url)) {
                await launch(link.url);
              }
            },
            text: 'https://github.com/happy-sonday',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            linkStyle: const TextStyle(color: Colors.white),
          ),
        ),
        Container(
            padding: const EdgeInsets.all(10),
            child: TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red)),
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  Padding(padding: EdgeInsets.all(3)),
                  Text(
                    "프로필 수정하기",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            )),
      ],
    ));
  }
}
