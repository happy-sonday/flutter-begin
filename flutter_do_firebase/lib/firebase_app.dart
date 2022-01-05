import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_do_firebase/tabs_page.dart';

class FirebaseApp extends StatefulWidget {
  const FirebaseApp({Key? key, required this.analytics, required this.observer})
      : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _FirebaseAppState createState() => _FirebaseAppState(analytics, observer);
}

class _FirebaseAppState extends State<FirebaseApp> {
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  String _message = '';

  _FirebaseAppState(this.analytics, this.observer);

  void setMessage(String message) {
    setState(() {
      _message = message;
    });
  }

  Future<void> _sendAnalyticsEvent() async {
    // _sendAnalyticsEvent 호출시 애널리틱스에 Map 형태로 데이터를 보냄
    // NOTE: name 값은 은 띄어쓰기 허용안함
    await analytics.logEvent(name: 'test_evet', parameters: <String, dynamic>{
      'string': 'hello flutter',
      'int': 100,
    });

    setMessage('Analytics 보내기 성공');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Example'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: _sendAnalyticsEvent, child: const Text("테스트")),
            Text(
              _message,
              style: const TextStyle(color: Colors.blueAccent),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => TabsPage(observer),
              settings: RouteSettings(name: '/tabs')));
        },
        child: Icon(Icons.tab),
      ),
    );
  }
}
