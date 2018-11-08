import 'package:flutter/material.dart';
import 'package:gitta/route/category/category_route.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'hello',
      home: Scaffold(
        appBar: AppBar(
          title: Text('title'),
        ),
        backgroundColor: Colors.greenAccent,
        body: CategoryRoute(),
      ),
    );
  }
}
