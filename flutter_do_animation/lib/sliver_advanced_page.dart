import 'package:flutter/material.dart';
import 'dart:math' as math;

class SliverAdvancedPage extends StatefulWidget {
  const SliverAdvancedPage({Key? key}) : super(key: key);

  @override
  _SliverAdvancedPageState createState() => _SliverAdvancedPageState();
}

class _SliverAdvancedPageState extends State<SliverAdvancedPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter SliverAppBar Center Title Example',
      home: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxScrolled) {
            return [
              SliverAppBar(
                //appbar size when it fully expanded.
                expandedHeight: 200.0,
                //appbar remains visible after scrolling
                pinned: true,
                floating: false,

                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset(
                    'assets/snow-bg.jpg',
                    fit: BoxFit.cover,
                  ),
                  //make title centered.
                  centerTitle: true,
                  title: const Text(
                    "ANDROIDRIDE",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ];
          },
          body: const Center(
            child: Text("Flutter SliverAppBar Center Title Example"),
          ),
        ),
      ),
    );
  }

  Widget customCard(String text) {
    return Card(
        child: Container(
            height: 120,
            child: Center(child: Text(text, style: TextStyle(fontSize: 40)))));
  }
}
