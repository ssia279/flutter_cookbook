import 'package:flutter/material.dart';
import 'dart:async';

class ColorStream {
  late Stream colorStream;

  Stream<Color> getColors() async* {
    final colors = <Color>[
      Colors.blueGrey, Colors.amber, Colors.deepPurple, Colors.lightBlue, Colors.teal
    ];

    yield* Stream.periodic(Duration(seconds: 1), (int t) {
      int index = t % 5;
      return colors[index];
    });
  }
}

class NumberStream {
  StreamController<int> controller = StreamController<int>();

  void addNumberToSink(int newNumber) {
    controller.sink.add(newNumber);
  }

  void addError() {
    controller.sink.addError('error');
  }

  void close() {
    controller.close();
  }
}