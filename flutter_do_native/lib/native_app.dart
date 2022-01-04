import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NativeApp extends StatefulWidget {
  const NativeApp({Key? key}) : super(key: key);

  @override
  _NativeAppState createState() => _NativeAppState();
}

class _NativeAppState extends State<NativeApp> {
  static const platform = MethodChannel('com.flutter.dev/info');
  static const platform3 = MethodChannel('com.flutter.dev/dialog');
  String _deviceInfo = 'Unknown info';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Native 통신"),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              _deviceInfo,
              style: const TextStyle(fontSize: 30),
            ),
            TextButton(
                onPressed: () {
                  _showDialo();
                },
                child: const Text('네이티브 창 열기'))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _getDeviceInfo();
        },
        child: Icon(Icons.get_app),
      ),
    );
  }

  Future _getDeviceInfo() async {
    String deviceInfo;
    try {
      // 메서드 채널로 연결된 안드로이드에서 네이티브 API를 호출할 함수를 인자로 전달
      final String result = await platform.invokeMethod('getDeviceInfo');
      deviceInfo = 'Device Info : $result';
    } on PlatformException catch (e) {
      deviceInfo = 'Failed to get Device info : ${e.message}';
    }

    setState(() {
      _deviceInfo = deviceInfo;
    });
  }

  Future<void> _showDialo() async {
    try {
      await platform3.invokeMethod('showDialog');
    } on PlatformException catch (e) {}
  }
}
