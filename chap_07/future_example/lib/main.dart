import 'dart:async';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:future_example/geolocation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Future Demo',
      theme: ThemeData(primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: FuturePage(),
      home: LocationScreen(),
    );
  }

}

class FuturePage extends StatefulWidget {
  @override
  _FuturePageState createState() {
    return _FuturePageState();
  }

}

class _FuturePageState extends State<FuturePage> {
  String? result;
  Completer? completer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Back from the Future'),
      ),
      body: Center(
        child: Column(
          children: [
            Spacer(),
            ElevatedButton(
                onPressed: () {
                  //count();
                  returnFutureGropResult();
                } /*{
                  result = '';
                  setState(() {
                    result = result;
                  });
                  getData().then((value) {
                    result = value.body.toString().substring(0, 450);
                    setState(() {
                      result = result;
                    });
                  }).catchError((_){
                    result = 'An error occurred';
                    setState(() {
                      result = result;
                    });
                  });
                },*/,
                child: Text('GO!')
            ),
            Spacer(),
            Text(result.toString()),
            Spacer(),
            CircularProgressIndicator(),
            Spacer(),
          ],
        ),
      ),
    );
  }

  Future<Response> getData() async {
    final String authority = 'www.googleapis.com';
    final String path = '/books/v1/volumes/junbDwAAQBAJ';
    Uri url = Uri.https(authority, path);
    return http.get(url);
  }

  Future<int> returnOneAsync() async {
    await Future.delayed(const Duration(seconds: 3));
    return 1;
  }

  Future<int> returnTwoAsync() async {
    await Future.delayed(const Duration(seconds: 3));
    return 2;
  }

  Future<int> returnThreeAsync() async {
    await Future.delayed(const Duration(seconds: 3));
    return 3;
  }

  Future count() async {
    int total = 0;
    total = await returnOneAsync();
    total = total + await returnTwoAsync();
    total = total + await returnThreeAsync();
    setState(() {
      result = total.toString();
    });
  }

  Future getNumber() {
    completer = Completer<int>();
    calculate();
    return completer!.future;
  }

  void calculate() async {
    await new Future.delayed(const Duration(seconds: 5));
    completer?.complete(42);
  }

  void returnFutureGropResult() {
    FutureGroup<int> futureGroup = FutureGroup<int>();
    futureGroup.add(returnOneAsync());
    futureGroup.add(returnTwoAsync());
    futureGroup.add(returnThreeAsync());
    futureGroup.close();

    futureGroup.future.then((List<int> value) {
      int total = 0;
      value.forEach((element) {total = total + element;});
      setState(() {
        result = total.toString();
      });
    });

  }

}