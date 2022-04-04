import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }

}

class _MyHomePageState extends State<MyHomePage> {
  late String documentsPath = '';
  late String tempPath = '';
  File? myFile;
  String fileText = '';
  final storage = FlutterSecureStorage();
  final myKey = 'myPass';
  final pwdController = TextEditingController();
  String? myPass = '';

  @override
  void initState() {
    getPaths().then((_){
      myFile = File('$documentsPath/pizzas.txt');
      writeFile();
    } );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Path Provider')),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(documentsPath),
            Text(tempPath),
            TextField(
              controller: pwdController,
            ),
            ElevatedButton(
                onPressed: () => readFile(),
                child: Text('Read File')),
            ElevatedButton(
                onPressed: () => writeToSecureStorage(),
                child: Text('Save Value')),
            ElevatedButton(
                onPressed: () => readFromSecureStorage().then((value) {
                  setState(() {
                    myPass = value;
                  });
                }),
                child: Text('Read Value')),
            Text(fileText),
            Text(myPass!),
          ],
        ),
      ),
    );
  }

  Future getPaths() async {
    final docDir = await getApplicationDocumentsDirectory();
    final tempDir = await getTemporaryDirectory();
    setState(() {
      documentsPath = docDir.path;
      tempPath = tempDir.path;
    });
  }

  Future<bool> writeFile() async {
    try {
      await myFile?.writeAsString('Margherita, Capricciosa, Napoli');
      return true;
    }catch (e) {
      return false;
    }
  }

  Future<bool> readFile() async {
    try {
      String? fileContent = await myFile?.readAsString();
      setState(() {
        fileText = fileContent?? 'Sorry, not data';
      });
      return true;
    }catch (e) {
      return false;
    }
  }

  Future writeToSecureStorage() async {
    await storage.write(key: myKey, value: pwdController.text);
  }

  Future<String?> readFromSecureStorage() async {
    String? secret = await storage.read(key: myKey);
    return secret;
  }

}

