import 'package:flutter/material.dart';
import 'package:receive_input/DemoPage.dart';
import 'package:receive_input/Storage.dart';
import 'package:receive_input/HomePage.dart';
import 'package:receive_input/Monnify.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Monnify(),

    );
  }
}
