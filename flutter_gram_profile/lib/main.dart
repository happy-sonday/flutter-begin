import 'package:flutter/material.dart';
import 'package:flutter_gram_profile/components/profile_buttons.dart';
import 'package:flutter_gram_profile/components/profile_count_info.dart';
import 'package:flutter_gram_profile/components/profile_drawer.dart';
import 'package:flutter_gram_profile/components/profile_header.dart';
import 'package:flutter_gram_profile/components/profile_tab.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const ProfileDrawer(),
      appBar: _buildProfileAppBar(),
      body: Column(
        children: [
          SizedBox(height: 20),
          ProfileHeader(),
          SizedBox(height: 20),
          ProfileCountInfo(),
          SizedBox(height: 20),
          ProfileButtons(),
          Expanded(child: ProfileTab()),
        ],
      ),
    );
  }

  AppBar _buildProfileAppBar() {
    return AppBar(
      leading: const Icon(
        Icons.arrow_back_ios,
        color: Colors.black,
      ),
      backgroundColor: Colors.white,
      elevation: 1.0,
      title: const Text(
        "프로필",
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.black),
    );
  }
}
