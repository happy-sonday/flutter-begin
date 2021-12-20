import 'package:flutter/material.dart';
import 'package:flutter_kakao_chat/screens/chat_screen.dart';
import 'package:flutter_kakao_chat/screens/friend_screen.dart';
import 'package:flutter_kakao_chat/screens/more_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainScreen extends StatefulWidget {
  //const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: const [
            // Center(child: Text("IndexedStack1")),
            // Center(child: Text("IndexedStack2")),
            // Center(child: Text("IndexedStack3")),
            FriendScreen(),
            ChatScreen(),
            MoreScreen()
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: _selectedIndex,
          backgroundColor: Colors.grey[100],
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black54,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.user),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.comment),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.ellipsisH),
              label: "",
            ),
          ],
        ));
  }
}
