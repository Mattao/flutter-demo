import 'package:flutter/material.dart';
import 'package:unit_converter/model/Category.dart';
import 'package:unit_converter/route/converter_route.dart';

final _rowHeight = 100.0;
final _borderRadius = BorderRadius.circular(_rowHeight / 2);

/// A custom [CategoryTile] widget.
///
/// The widget is composed on an [Icon] and [Text]. Tapping on the widget shows
/// a colored [InkWell] animation.
class CategoryTile extends StatelessWidget {
  final Category category;

  const CategoryTile({
    Key key,
    @required this.category,
  })  : assert(category != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: _rowHeight,
        child: InkWell(
          borderRadius: _borderRadius,
          highlightColor: category.color,
          splashColor: category.color,
          onTap: () => _navigatorToConverter(context),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(
                    category.iconLocation,
                    size: 60.0,
                  ),
                ),
                Center(
                  child: Text(
                    category.name,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigatorToConverter(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              category.name,
            ),
          ),
          body: ConverterRoute(
            color: category.color,
            name: category.name,
            units: category.units,
          ),
        );
      },
    ));
  }
}
