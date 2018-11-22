import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:unit_converter/model/Category.dart';
import 'package:unit_converter/model/Unit.dart';
import 'package:unit_converter/route/category/category_tile.dart';
import 'package:unit_converter/route/unit_converter_route.dart';
import 'package:unit_converter/widget/backdrop.dart';

class CategoryListRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CategoryListRouteState();
  }
}

class _CategoryListRouteState extends State<CategoryListRoute> {
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

  final _categories = <Category>[];

  Category _currentCategory;

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    if (_categories.isEmpty) {
      await _retrieveLocalCategories();
    }
  }

  Future<void> _retrieveLocalCategories() async {
    final json = DefaultAssetBundle.of(context)
        .loadString('assets/data/regular_units.json');
    final data = JsonDecoder().convert(await json);
    if (data is! Map) {
      throw ('Data retrived from API is not a Map');
    }

    var categoryIndex = 0;
    data.keys.forEach((key) {
      List<Unit> units =
          data[key].map<Unit>((dynamic data) => Unit.fromJson(data)).toList();

      var category = Category(
        name: key,
        units: units,
        color: _colors[categoryIndex],
        iconLocation: _icons[categoryIndex],
      );
      _categories.add(category);

      if (categoryIndex == 0) {
        _currentCategory = category;
      }

      categoryIndex++;
    });
  }

  void _onCategoryTap(Category category) {
    setState(() {
      _currentCategory = category;
    });
  }

  Widget _buildCategoryListWidget(Orientation deviceOrientation) {
    if (Orientation.portrait == deviceOrientation) {
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) => CategoryTile(
              category: _categories[index],
              onTap: _onCategoryTap,
            ),
        itemCount: _categories.length,
      );
    } else {
      return GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 3.0,
        children: _categories
            .map((category) => CategoryTile(
                  category: category,
                  onTap: _onCategoryTap,
                ))
            .toList(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    var categoryListView = Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: _buildCategoryListWidget(MediaQuery.of(context).orientation),
    );

    return Backdrop(
      backPanel: categoryListView,
      backTitle: Text('Select a Category'),
      currentCategory: _currentCategory,
      frontPanel: UnitConverterRoute(
        category: _currentCategory,
      ),
      frontTitle: Text('Unit Converter'),
    );
  }
}
