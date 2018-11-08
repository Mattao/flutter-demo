import 'package:flutter/material.dart';
import 'package:unit_converter/route/category/category_route.dart';

void main() => runApp(MyApp());

const _title = 'Unit Conventer';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(_title),
        ),
        body: CategoryRoute(),
      ),
    );
  }
}
