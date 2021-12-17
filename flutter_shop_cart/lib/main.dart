import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_shop_cart/components/shoppingcart_detail.dart';
import 'package:flutter_shop_cart/components/shoppingcart_header.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: ShoppingCartPage(),
    );
  }
}

class ShoppingCartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _bulidShoppingCartAppBar(),
      body: ListView(children: [
        Column(children: [
          ShoppingCartHeader(),
          ShoppingCartDetail(),
        ]),
      ]),
    );
  }

  AppBar _bulidShoppingCartAppBar() {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onPressed: () {},
      ),
      actions: [
        IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {}),
        SizedBox(width: 16)
      ],
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }
}
