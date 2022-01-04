import 'dart:math';

import 'package:flutter/material.dart';

class SaturnLoading extends StatefulWidget {
  _SaturnLoadingState _saturnLoadingState = _SaturnLoadingState();

  void start() {
    _saturnLoadingState.start();
  }

  void stop() {
    _saturnLoadingState.stop();
  }

  @override
  _SaturnLoadingState createState() => _SaturnLoadingState();
}

class _SaturnLoadingState extends State<SaturnLoading>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation? _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // NOTE: 초당 60frame , {sencond}초동안 현재 페이지(this)에서 애니메이션 동작

    _animationController =
        AnimationController(duration: const Duration(seconds: 10), vsync: this);

    // NOTE: 애니메이션 컨트롤러 숫자범위는 0.0~1.0으로 다른 범위의 데이터 유형이 필요한 경우 Tween을 이용해서 구성

    _animation =
        Tween<double>(begin: 0, end: pi * 2).animate(_animationController!);

    _animationController!.repeat();
  }

  // NOTE: 화면이 종료될 때 호출하는 함수로, controller 객체를 없애주지 않으면 화면을 그리려고 시도하고 해당 대상이 없어서 오류가 발생
  @override
  void dispose() {
    _animationController!.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController!,
      builder: (context, child) {
        return SizedBox(
          width: 100,
          height: 100,
          child: Stack(
            children: [
              Image.asset(
                'assets/circle.png',
                width: 100,
                height: 100,
              ),
              Center(
                child: Image.asset(
                  'assets/sunny.png',
                  width: 30,
                  height: 30,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Transform.rotate(
                  angle: _animation!.value,
                  origin: Offset(35, 35),
                  child: Image.asset(
                    'assets/saturn.png',
                    width: 20,
                    height: 20,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void start() {
    _animationController!.repeat();
  }

  void stop() {
    _animationController!.stop(canceled: true);
  }
}
