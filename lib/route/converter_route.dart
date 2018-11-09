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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(units[1].name),
    );
  }
}
