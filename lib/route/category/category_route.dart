import 'package:flutter/material.dart';
import 'package:unit_converter/route/category/category.dart';

class CategoryRoute extends StatelessWidget {
  static const _categoryNames = <String>[
    'Length',
    'Area',
    'Volume',
    'Mass',
    'Time',
    'Digital Storage',
  ];
  static const _colors = <Color>[
    Colors.teal,
    Colors.orange,
    Colors.pinkAccent,
    Colors.greenAccent,
    Colors.teal,
    Colors.red,
  ];
  static const _icons = <IconData>[
    Icons.cached,
    Icons.volume_up,
    Icons.timer,
    Icons.monetization_on,
    Icons.cake,
    Icons.grade,
  ];

  Widget _buildCategoryListWidget(List<Widget> categoryWidgets) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) => categoryWidgets[index],
      itemCount: categoryWidgets.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    final categoryWidgets = <Category>[];
    for (var i = 0; i < _categoryNames.length; i++) {
      categoryWidgets.add(Category(
        name: _categoryNames[i],
        color: _colors[i],
        iconLocation: _icons[i],
      ));
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: _buildCategoryListWidget(categoryWidgets),
    );
  }
}
