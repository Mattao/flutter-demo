import 'package:flutter/material.dart';
import 'package:gitta/widget/category.dart';

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
        body: Center(
          child: Category(
            iconData: Icons.cached,
            text: 'trash',
            rippleColor: Colors.orangeAccent,
          ),
        ),
      ),
    );
  }
}
