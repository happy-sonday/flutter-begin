import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';

class TabsPage extends StatefulWidget {
  final FirebaseAnalyticsObserver observer;

  TabsPage(this.observer);

  @override
  _TabsPageState createState() => _TabsPageState(observer);
}

class _TabsPageState extends State<TabsPage>
    with SingleTickerProviderStateMixin, RouteAware {
  final FirebaseAnalyticsObserver observer;
  TabController? _controller;
  int selectedIndex = 0;

  _TabsPageState(this.observer);

  final List<Tab> tabs = <Tab>[
    const Tab(
      text: '1번',
      icon: Icon(Icons.looks_one),
    ),
    const Tab(
      text: '2번',
      icon: Icon(Icons.looks_two),
    ),
    const Tab(
      text: '3번',
      icon: Icon(Icons.looks_3),
    )
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(
        length: tabs.length, initialIndex: selectedIndex, vsync: this);

    // 탭 메뉴를 클릭했을 때 발생하는 이벤트 처리
    _controller!.addListener(() {
      setState(() {
        if (selectedIndex != _controller!.index) {
          selectedIndex = _controller!.index;
          // 탭 포커스 됐을 때 현재 화면 이름을 파이어 베이스에 보냄
          _sendCurrentTab();
        }
      });
    });
  }

// initState() 함수 다음에 상태 변화가 생겼을 때 호출되는 함수
// dispose() 함수가 호출되기 전에도 호출된다.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 데이터 상태를 체크하기 위해 구독
    observer.subscribe(this, ModalRoute.of(context) as dynamic);
  }

  @override
  void dispose() {
    // observer 메모리 누수를 위해 해당 페이지를 벗어나면 구독 해지
    observer.unsubscribe(this);
    super.dispose();
  }

  void _sendCurrentTab() {
    // 현재 화면의 이름을 애널리틱스에 전달
    print('_sendCurrentTab() 실행 : $selectedIndex');
    observer.analytics.setCurrentScreen(screenName: 'tab/$selectedIndex');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          tabs: tabs,
          controller: _controller,
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: tabs
            .map((Tab tab) => Center(
                  child: Text(tab.text!),
                ))
            .toList(),
      ),
    );
  }
}
