import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation? _rotateAnimation;
  Animation? _scaleAnimation;
  Animation? _transAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // NOTE: 초당 60frame , 5초동안 현재 페이지(this)에서 애니메이션 동작

    _animationController =
        AnimationController(duration: Duration(seconds: 5), vsync: this);

    // NOTE: 애니메이션 컨트롤러 숫자범위는 0.0~1.0으로 다른 범위의 데이터 유형이 필요한 경우 Tween을 이용해서 구성
    _rotateAnimation =
        Tween<double>(begin: 0, end: pi * 10).animate(_animationController!);
    _scaleAnimation =
        Tween<double>(begin: 1, end: 0).animate(_animationController!);
    _transAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(200, 200))
            .animate(_animationController!);
  }

  // NOTE: 화면이 종료될 때 호출하는 함수로, controller 객체를 없애주지 않으면 화면을 그리려고 시도하고 해당 대상이 없어서 오류가 발생
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Animation Example"),
        ),
        body: Container(
          child: Center(
            child: Column(
              children: [
                AnimatedBuilder(
                  animation: _rotateAnimation!,
                  builder: (context, widget) {
                    return Transform.translate(
                      offset: _transAnimation!.value,
                      child: Transform.rotate(
                        angle: _rotateAnimation!.value,
                        child: Transform.scale(
                          scale: _scaleAnimation!.value,
                          child: widget,
                        ),
                      ),
                    );
                  },
                  child: const Hero(
                      tag: 'detail',
                      child: Icon(
                        Icons.cake,
                        size: 150,
                      )),
                ),
                ElevatedButton(
                    onPressed: () {
                      _animationController!.forward();
                    },
                    child: const Text("로테이션 시작하기"))
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ),
        ));
  }
}
