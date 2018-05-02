import 'package:flutter/material.dart';
import 'package:hello/page/WordListPage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Welcome',
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
      home: new WordListPage(),
    );
  }
}
