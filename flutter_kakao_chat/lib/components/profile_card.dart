import 'package:flutter/material.dart';
import 'package:flutter_kakao_chat/models/user.dart';
import 'package:flutter_kakao_chat/screens/profile_screen.dart';

class ProfileCard extends StatelessWidget {
  final User user;
  const ProfileCard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //해당 프로필 클릭시, 프로필 상세 화면 노출
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ProfileScreen(user: user)));
      },
      child: ListTile(
        leading: CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage(user.backgroundImage),
        ),
        title: Text(
          user.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          user.intro,
          style: const TextStyle(fontSize: 12),
        ),
      ),
    );
  }
}
