import 'package:flutter/material.dart';
import 'package:flutter_gram_login/size.dart';

class CustomTextFormField extends StatelessWidget {
  final String text;

  const CustomTextFormField(this.text);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text),
        const SizedBox(height: small_gap),
        // NOTE: 느낌표는 null-forgiving 연산자로 null이 전달될 것이고 경고를 표시하지 않아야 함을 컴파일러에 알림
        TextFormField(
          validator: (value) =>
              value!.isEmpty ? "Please enter some text" : null,
          obscureText: text == "Password" ? true : false,
          decoration: InputDecoration(
              hintText: "Enter $text",
              enabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              focusedBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              errorBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              focusedErrorBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
        )
      ],
    );
  }
}
