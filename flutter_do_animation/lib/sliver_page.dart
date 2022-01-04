import 'package:flutter/material.dart';

import 'header-delegate.dart';

class SliverPage extends StatefulWidget {
  const SliverPage({Key? key}) : super(key: key);

  @override
  _SliverPageState createState() => _SliverPageState();
}

class _SliverPageState extends State<SliverPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // 앱바의 최대 높이 설정
          // SliverAppBar는 CustomScrollView에서만 한정 다른 기본적인 Container 위젯에서는 사용불가
          const SliverAppBar(
            expandedHeight: 150.0,
            // NOTE: 머터리얼 디자인 앱바를 확장하거나 축소, 스트레칭 해준다.
            flexibleSpace: FlexibleSpaceBar(
              title: Text("Sliver Example"),
            ),
            backgroundColor: Colors.deepOrangeAccent,
            // pinned는 기본 fasle, true는 스크롤시 사라지지 않고 일정 높이를 유지하게 된다.
            pinned: true,
          ),
          SliverPersistentHeader(
            delegate: HeaderDelegate(
                minHeight: 50,
                maxHeight: 150,
                child: Container(
                  color: Colors.blue,
                  child: Center(
                    child: Column(
                      children: const [
                        Text(
                          "list 숫자",
                          style: TextStyle(fontSize: 30),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ),
                )),
            pinned: true,
          ),

          SliverList(
              delegate: SliverChildListDelegate([
            customCard('1'),
            customCard('2'),
            customCard('3'),
            customCard('4'),
            customCard('5'),
          ])),

          // NOTE: SliverChildListDelegate 일일이 배열에 요소를 넣지 않고
          // SliverChildBuilderDelegate로 한번에 생성 가능
          SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
            return Container(child: customCard('list count : $index'));
          }, childCount: 10)),
          SliverPersistentHeader(
            delegate: HeaderDelegate(
                minHeight: 50,
                maxHeight: 150,
                child: Container(
                  color: Colors.blue,
                  child: Center(
                    child: Column(
                      children: const [
                        Text(
                          "grid 숫자",
                          style: TextStyle(fontSize: 30),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ),
                )),
            pinned: true,
          ),
          SliverGrid(
              delegate: SliverChildListDelegate([
                customCard('1'),
                customCard('2'),
                customCard('3'),
                customCard('4'),
                customCard('5'),
                customCard('6'),
                customCard('7'),
                customCard('8'),
                customCard('9'),
              ]),
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2))
        ],
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
