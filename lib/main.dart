import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'src/ui/home/homepage.dart';
import 'src/Lang.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: lang.appName(),
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: lang.homeScreenTitle()),
    );
  }
}