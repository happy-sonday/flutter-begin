// 머리말을 만들때 사용할 위젯을 배치하는 클래스
import 'package:flutter/material.dart';
import 'dart:math' as math;

class HeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  HeaderDelegate(
      {required this.minHeight, required this.maxHeight, required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  // 위젯의 최대 높이 설정
  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  // 가장 작은 높이 설정 해당 높이 이하로 줄어들지 않음
  @override
  double get minExtent => minHeight;

  // 위젯을 계속 그릴지 정함 maxHeight/minHeight,child가 달라지면 true를 반환해 계속 그림
  @override
  bool shouldRebuild(HeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
