import 'package:flutter/material.dart';
import 'package:unit_converter/model/Unit.dart';
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

  List<Unit> _retrieveUnitList(String categoryName) {
    return List.generate(10, (int index) {
      index += 1;
      return Unit(
        name: '$categoryName Unit $index',
        conversion: index.toDouble(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final categoryWidgets = <Category>[];
    for (var i = 0; i < _categoryNames.length; i++) {
      categoryWidgets.add(Category(
        name: _categoryNames[i],
        color: _colors[i],
        iconLocation: _icons[i],
        units: _retrieveUnitList(_categoryNames[i]),
      ));
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: _buildCategoryListWidget(categoryWidgets),
    );
  }
}
