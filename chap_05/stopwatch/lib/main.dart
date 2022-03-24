import 'package:flutter/material.dart';
import 'package:stopwatch/views/login_screen.dart';
import 'package:stopwatch/views/stopwatch.dart';

void main() {
  runApp(StopWatchApp());
}

class StopWatchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
    );
  }

}