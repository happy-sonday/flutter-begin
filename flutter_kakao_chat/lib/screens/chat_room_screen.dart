import 'package:flutter_kakao_chat/components/chat_icon_button.dart';
import 'package:flutter_kakao_chat/components/chat_time_line.dart';

import 'package:flutter/material.dart';
import 'package:flutter_kakao_chat/components/my_chat.dart';
import 'package:flutter_kakao_chat/components/other_chat.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({Key? key}) : super(key: key);

  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final List<MyChat> chats = [];
  final TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFb2c7da),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            "사용자이름",
            style: Theme.of(context).textTheme.headline6,
          ),
          actions: const [
            Icon(FontAwesomeIcons.search, size: 20),
            SizedBox(width: 25),
            Icon(FontAwesomeIcons.bars, size: 20),
            SizedBox(width: 25),
          ],
        ),
        body: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  const ChatTimeLine(time: "2021년 12월 25일 토요일"),
                  const OtherChat(
                      text: "메리크리스마스!!", time: "오전 10:10", name: "소희"),
                  const MyChat(text: "너두 즐거운 크리스마스 보내:)!!!!", time: "오전 10:10"),
                  // 추가 채팅 입력 내용
                  ...List.generate(chats.length, (index) => chats[index]),
                ],
              ),
            )),
            Container(
              height: 60,
              color: Colors.white,
              child: Row(
                children: [
                  const ChatIconButton(icon: Icon(FontAwesomeIcons.plusSquare)),
                  Expanded(
                      child: Container(
                    child: TextField(
                      controller: _textEditingController,
                      maxLines: 1,
                      style: const TextStyle(fontSize: 20),
                      decoration: const InputDecoration(
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none),
                      onSubmitted: _handleSubmitted,
                    ),
                  )),
                  const ChatIconButton(icon: Icon(FontAwesomeIcons.smile)),
                  const ChatIconButton(icon: Icon(FontAwesomeIcons.cog))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _handleSubmitted(text) {
    _textEditingController.clear();
    setState(() {
      chats.add(
        MyChat(
          text: text,
          time: DateFormat("a K:m")
              .format(new DateTime.now())
              .replaceAll("AM", "오전")
              .replaceAll("PM", "오후"),
        ),
      );
    });
  }
}
