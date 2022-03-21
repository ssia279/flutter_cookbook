import 'package:flutter/material.dart';
import 'package:widget_tree/views/deep_tree.dart';
import 'package:widget_tree/views/e_commerce_screen_before.dart';
import 'package:widget_tree/views/flex_screen.dart';
import 'package:widget_tree/views/profile_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ECommerceScreen(),
    );
  }
}