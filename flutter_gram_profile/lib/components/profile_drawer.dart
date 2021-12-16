import 'package:flutter/material.dart';

class ProfileDrawer extends StatelessWidget {
  const ProfileDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 32, right: 12, left: 12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Icon(
                  Icons.home_outlined,
                  color: Colors.black87,
                  size: 32,
                ),
                SizedBox(width: 8),
                Text(
                  "Home",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black87, fontSize: 18),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Icon(
                  Icons.search_outlined,
                  color: Colors.black87,
                  size: 32,
                ),
                SizedBox(width: 8),
                Text(
                  "Search",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black87, fontSize: 18),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Icon(
                  Icons.movie_creation,
                  color: Colors.black87,
                  size: 32,
                ),
                SizedBox(width: 8),
                Text(
                  "Reels",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black87, fontSize: 18),
                ),
              ],
            ),
            Expanded(child: SizedBox()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Text(
                  "My",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                    decoration: TextDecoration.underline,
                  ),
                ),
                Text(
                  "LogOut",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
