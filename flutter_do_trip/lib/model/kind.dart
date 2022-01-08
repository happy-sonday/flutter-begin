import 'package:flutter/material.dart';

import 'item.dart';

class Kind {
  List<DropdownMenuItem<Item>> kinds = [];

  Kind() {
    kinds.add(DropdownMenuItem(
      child: const Text('관광지'),
      value: Item('관광지', 12),
    ));
    kinds.add(DropdownMenuItem(
      child: const Text('문화시설'),
      value: Item('문화시설', 14),
    ));
    kinds.add(DropdownMenuItem(
      child: const Text('축제/공연'),
      value: Item('축제/공연', 15),
    ));
    kinds.add(DropdownMenuItem(
      child: const Text('여행코스'),
      value: Item('여행코스', 25),
    ));
    kinds.add(DropdownMenuItem(
      child: const Text('레포츠'),
      value: Item('레포츠', 28),
    ));
    kinds.add(DropdownMenuItem(
      child: const Text('숙박'),
      value: Item('숙박', 32),
    ));
    kinds.add(DropdownMenuItem(
      child: const Text('쇼핑'),
      value: Item('쇼핑', 38),
    ));
    kinds.add(DropdownMenuItem(
      child: const Text('음식'),
      value: Item('음식', 39),
    ));
    kinds.add(DropdownMenuItem(
      child: const Text('전체'),
      value: Item('전체', 0),
    ));
  }
}
