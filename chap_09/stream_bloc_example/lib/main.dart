import 'package:flutter/material.dart';
import 'package:stream_bloc_example/countdown_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
  late TimerBLoC timerBLoC;
  late int seconds;

  @override
  void initState() {
    timerBLoC = TimerBLoC();
    seconds = timerBLoC.seconds;
    timerBLoC.countDown();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: timerBLoC.secondsStream,
        initialData: seconds,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('Error');
          }
          if (snapshot.hasData) {
            return Center(
              child: Text(snapshot.data.toString(),
              style: TextStyle(fontSize: 96),),
            );
          } else {
            return Center();
          }
        },
      ),
    );
  }

}