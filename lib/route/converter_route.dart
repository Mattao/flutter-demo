import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:unit_converter/model/Unit.dart';

class ConverterRoute extends StatelessWidget {
  /// This [Category]'s name.
  final String name;

  /// Color for this [Category].
  final Color color;

  /// Units for this [Category].
  final List<Unit> units;

  const ConverterRoute({
    @required this.name,
    @required this.color,
    @required this.units,
  })  : assert(name != null),
        assert(color != null),
        assert(units != null);

  Widget _buildUnitItem(BuildContext context, Unit unit) {
    return Container(
      color: color,
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Text(
            unit.name,
            style: Theme.of(context).textTheme.headline,
          ),
          Text(
            unit.conversion.toString(),
            style: Theme.of(context).textTheme.subhead,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final unitWidgets =
        units.map((Unit unit) => _buildUnitItem(context, unit)).toList();
    return ListView(
      children: unitWidgets,
    );
  }
}
