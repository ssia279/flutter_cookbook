import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:stream_demo/stream.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stream',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      home: StreamHomePage(),
    );
  }
}

class StreamHomePage extends StatefulWidget {
  @override
  _StreamHomePageState createState() {
    return _StreamHomePageState();
  }

}

class _StreamHomePageState extends State<StreamHomePage> {
  //late Color bgColor;
  //late ColorStream colorStream;
  int? lastNumber;
  late StreamController numberStreamController;
  late NumberStream numberStream;
  late StreamTransformer transformer;
  late StreamSubscription subscription;
  late StreamSubscription subscription2;
  String values = '';

  @override
  void initState() {
    //colorStream = ColorStream();
    //changeColor();
    numberStream = NumberStream();
    numberStreamController = numberStream.controller;
    Stream stream = numberStreamController.stream.asBroadcastStream();
    subscription = stream.listen((event) {
      setState(() {
        values += event.toString() + ' - ';
      });
    });

    subscription2 = stream.listen((event) {
      values += event.toString() + ' - ';
    });

    subscription.onError((error) {
      setState(() {
        lastNumber = -1;
      });
    });

    subscription.onDone(() {
      print('onDone was called');
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Stream'),
        ),
        body: Container(
          //decoration: BoxDecoration(color: bgColor),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(values),
              ElevatedButton(
                  onPressed: () => addRandomNumber(),
                  child: Text('New Random Number')),
              ElevatedButton(
                onPressed: () => stopStream(),
                child: Text('Stop Stream'),
              ),
            ],
          ),
        ));
  }

  void addRandomNumber() {
    Random random = Random();
    int myNum = random.nextInt(10);
    if (!numberStreamController.isClosed) {
      numberStream.addNumberToSink(myNum);
    } else {
      setState(() {
        lastNumber = -1;
      });
    }

    //numberStream.addError();
  }

  void stopStream() {
    numberStreamController.close();
  }

  /*
  changeColor() async {
    await for (var eventColor in colorStream.getColors()) {
      setState(() {
        bgColor = eventColor;
      });
    }
  }*/

}