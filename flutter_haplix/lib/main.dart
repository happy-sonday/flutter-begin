import 'package:flutter/material.dart';
import 'package:flutter_haplix/screen/home_screen.dart';
import 'package:flutter_haplix/screen/more_screnn.dart';
import 'package:flutter_haplix/widget/bottom_bar.dart';

void main(List<String> args) {
  return runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Haplix",
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        accentColor: Colors.white,
      ),
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              HomeScreen(),
              Container(
                child: Center(
                  child: Text("search"),
                ),
              ),
              Container(
                child: Center(
                  child: Text("saved"),
                ),
              ),
              // Container(
              //   child: Center(
              //     child: Text("more"),
              //   ),
              // ),
              MoreScreen()
            ],
          ),
          bottomNavigationBar: BottomBar(),
        ),
      ),
    );
  }
}
