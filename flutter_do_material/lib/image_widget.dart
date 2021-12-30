import 'package:flutter/material.dart';

class ImageWidgetApp extends StatefulWidget {
  const ImageWidgetApp({Key? key}) : super(key: key);

  @override
  _ImageWidgetAppState createState() => _ImageWidgetAppState();
}

class _ImageWidgetAppState extends State<ImageWidgetApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Widget"),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/netflix_logo.png",
                width: 200,
                height: 100,
                fit: BoxFit.fitHeight,
              ),
              const Text(
                "Nefilx",
                style: TextStyle(
                    fontFamily: 'Nautigal', fontSize: 35, color: Colors.red),
              )
            ],
          ),
        ),
      ),
    );
  }
}
