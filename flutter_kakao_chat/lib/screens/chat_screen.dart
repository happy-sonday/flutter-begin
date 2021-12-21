import 'package:flutter/material.dart';
import 'package:flutter_kakao_chat/components/chat_card.dart';
import 'package:flutter_kakao_chat/models/chat.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("채팅"),
      ),
      body: ListView(
        children: List.generate(
            chats.length, (index) => ChatCard(chat: chats[index])),
      ),
    );
  }
}
