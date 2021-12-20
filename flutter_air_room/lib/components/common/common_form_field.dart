import 'package:flutter/material.dart';
import 'package:flutter_air_room/styles.dart';

class CommonFormField extends StatelessWidget {
  final prefixText;
  final hintText;
  const CommonFormField({required this.prefixText, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      TextFormField(
        textAlignVertical: TextAlignVertical.bottom,
        decoration: InputDecoration(
            //TextFormField 내부 패딩 set
            contentPadding: EdgeInsets.only(top: 30, left: 20, bottom: 10),
            hintText: hintText,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(
                // default skyblue, 색만지정하는경우에 border-radius가 적용안됨
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.black, width: 2))),
      ),
      // TextFormField 공간 내 글자를 삽입하기 위함
      Positioned(
          top: 8,
          left: 20,
          child: Text(
            prefixText,
            style: overline(),
          ))
    ]);
  }
}
