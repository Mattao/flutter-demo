import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:unit_converter/api.dart';
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
    Colors.cyan,
  ];
  static const _icons = <String>[
    'assets/icons/length.png',
    'assets/icons/area.png',
    'assets/icons/volume.png',
    'assets/icons/mass.png',
    'assets/icons/time.png',
    'assets/icons/digital_storage.png',
    'assets/icons/power.png',
    'assets/icons/currency.png',
  ];

  final _categories = <Category>[];

  Category _currentCategory;

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    if (_categories.isEmpty) {
      await _retrieveLocalCategories();
      await _retrieveApiCategory();
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

      setState(() {
        if (categoryIndex == 0) {
          _currentCategory = category;
        }
      });

      categoryIndex++;
    });
  }

  Future<void> _retrieveApiCategory() async {
    // add a placehoder
    setState(() {
      _categories.insert(
          0,
          Category(
            name: apiCategory['name'],
            color: _colors.last,
            iconLocation: _icons.last,
            units: <Unit>[],
          ));
    });

    final api = Api();
    final jsonUnits = await api.getUnits(apiCategory['route']);
    if (jsonUnits != null) {
      final units = <Unit>[];
      for (var unit in jsonUnits) {
        units.add(Unit.fromJson(unit));
      }

      setState(() {
        _categories.removeAt(0);
        _categories.insert(
            0,
            Category(
              name: apiCategory['name'],
              color: _colors.last,
              iconLocation: _icons.last,
              units: units,
            ));
      });
    }
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
    if (_categories.isEmpty) {
      return Center(
        child: Container(
          height: 180.0,
          width: 180.0,
          child: CircularProgressIndicator(),
        ),
      );
    }

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
