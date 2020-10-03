import 'package:Queuemahogany/screens/home.dart';
//import 'package:Queuemahogany/screens/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: "Mahogany's Queue",
      theme: ThemeData.light().copyWith(
        accentColor: Colors.amber,
        primaryColor: Colors.amber,
      ),
      home: Home(),
      //home: MyHomePage(),
    );
  }
}
