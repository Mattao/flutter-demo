import 'package:flutter/material.dart';
import 'package:unit_converter/route/category/category_list_route.dart';

void main() => runApp(MyApp());

const _title = 'Unit Conventer';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: CategoryListRoute(),
      theme: ThemeData(
        fontFamily: 'Raleway',
      ),
    );
  }
}
