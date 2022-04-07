import 'package:flutter/material.dart';
import 'package:stream_example_2/stream.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
  late Stream<int> numberStream;

  @override
  void initState() {
    numberStream = NumberStream().getNumbers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stream')),
      body: Container(
        child: StreamBuilder(
          stream: numberStream,
          initialData: 0,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print('Error!');
            }
            if (snapshot.hasData) {
              return Center(
                child: Text(snapshot.data.toString(),
                style: TextStyle(fontSize: 96),
                ),
              );
            } else {
              return Center();
            }
          },
        ),
      ),
    );
  }

}
