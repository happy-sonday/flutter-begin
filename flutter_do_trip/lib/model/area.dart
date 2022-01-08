import 'package:flutter/material.dart';

import 'item.dart';

class Area {
  List<DropdownMenuItem<Item>> seoulArea = [];

  Area() {
    seoulArea.add(DropdownMenuItem(
      child: const Text('강남구'),
      value: Item('강남구', 1),
    ));
    seoulArea.add(DropdownMenuItem(
      child: const Text('강동구'),
      value: Item('강동구', 2),
    ));
    seoulArea.add(DropdownMenuItem(
      child: const Text('강북구'),
      value: Item('강북구', 3),
    ));
    seoulArea.add(DropdownMenuItem(
      child: const Text('강서구'),
      value: Item('강서구', 4),
    ));
    seoulArea.add(DropdownMenuItem(
      child: const Text('관악구'),
      value: Item('관악구', 5),
    ));
    seoulArea.add(DropdownMenuItem(
      child: const Text('광진구'),
      value: Item('광진구', 6),
    ));
    seoulArea.add(DropdownMenuItem(
      child: const Text('구로구'),
      value: Item('구로구', 7),
    ));
    seoulArea.add(DropdownMenuItem(
      child: const Text('금천구'),
      value: Item('금천구', 8),
    ));
    seoulArea.add(DropdownMenuItem(
      child: const Text('노원구'),
      value: Item('노원구', 9),
    ));
    seoulArea.add(DropdownMenuItem(
      child: const Text('도봉구'),
      value: Item('도봉구', 10),
    ));
    seoulArea.add(DropdownMenuItem(
      child: const Text('동대문구'),
      value: Item('동대문구', 11),
    ));
    seoulArea.add(DropdownMenuItem(
      child: const Text('동작구'),
      value: Item('동작구', 12),
    ));
    seoulArea.add(DropdownMenuItem(
      child: const Text('마포구'),
      value: Item('마포구', 13),
    ));
    seoulArea.add(DropdownMenuItem(
      child: const Text('서대문구'),
      value: Item('서대문구', 14),
    ));
    seoulArea.add(DropdownMenuItem(
      child: const Text('서초구'),
      value: Item('서초구', 15),
    ));
    seoulArea.add(DropdownMenuItem(
      child: const Text('성동구'),
      value: Item('성동구', 16),
    ));
    seoulArea.add(DropdownMenuItem(
      child: const Text('성북구'),
      value: Item('성북구', 17),
    ));
    seoulArea.add(DropdownMenuItem(
      child: const Text('송파구'),
      value: Item('송파구', 18),
    ));
    seoulArea.add(DropdownMenuItem(
      child: const Text('양천구'),
      value: Item('양천구', 19),
    ));
    seoulArea.add(DropdownMenuItem(
      child: const Text('영등포구'),
      value: Item('영등포구', 20),
    ));
    seoulArea.add(DropdownMenuItem(
      child: const Text('용산구'),
      value: Item('용산구', 21),
    ));
    seoulArea.add(DropdownMenuItem(
      child: const Text('은평구'),
      value: Item('은평구', 22),
    ));
    seoulArea.add(DropdownMenuItem(
      child: const Text('종로구'),
      value: Item('종로구', 23),
    ));
    seoulArea.add(DropdownMenuItem(
      child: const Text('중구'),
      value: Item('중구', 24),
    ));
    seoulArea.add(DropdownMenuItem(
      child: const Text('중랑구'),
      value: Item('중랑구', 25),
    ));
  }
}
