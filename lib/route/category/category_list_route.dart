import 'package:flutter/material.dart';
import 'package:unit_converter/model/Unit.dart';
import 'package:unit_converter/route/category/category_item.dart';

class CategoryListRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CategoryListRouteState();
  }
}

class _CategoryListRouteState extends State<CategoryListRoute> {
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

  final categoryWidgets = <CategoryItem>[];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < _categoryNames.length; i++) {
      categoryWidgets.add(CategoryItem(
        name: _categoryNames[i],
        color: _colors[i],
        iconLocation: _icons[i],
        units: _retrieveUnitList(_categoryNames[i]),
      ));
    }
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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: _buildCategoryListWidget(categoryWidgets),
    );
  }

  Widget _buildCategoryListWidget(List<Widget> categoryWidgets) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) => categoryWidgets[index],
      itemCount: categoryWidgets.length,
    );
  }
}
