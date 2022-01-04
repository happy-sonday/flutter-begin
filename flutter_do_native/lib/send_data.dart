import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SendDataApp extends StatefulWidget {
  const SendDataApp({Key? key}) : super(key: key);

  @override
  _SendDataAppState createState() => _SendDataAppState();
}

class _SendDataAppState extends State<SendDataApp> {
  // method 채널 이름 : com.flutter.dev/encrypto / 네이브 호출 메서드 : getEncrypto
  static const platform = MethodChannel('com.flutter.dev/encrypto');

  TextEditingController controller = TextEditingController();
  String _changeText = 'Nothing';
  String _reChangeText = 'Nothing';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Data'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              TextField(
                controller: controller,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                _changeText,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    _decodeText(_changeText);
                  },
                  child: const Text('디코딩하기')),
              const SizedBox(
                height: 20,
              ),
              Text(
                _reChangeText,
                style: const TextStyle(fontSize: 20),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _sendData(controller.value.text);
        },
        child: const Text('변환'),
      ),
    );
  }

  void _decodeText(String changeText) async {
    final String result = await platform.invokeMethod('getDecode', changeText);
    print(result);
    setState(() {
      _reChangeText = result;
    });
  }

  Future<void> _sendData(String text) async {
    final String result = await platform.invokeMethod('getEncrypto', text);
    print(result);
    setState(() {
      _changeText = result;
    });
  }
}
