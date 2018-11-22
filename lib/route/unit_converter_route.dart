import 'package:flutter/material.dart';
import 'package:unit_converter/api.dart';
import 'package:unit_converter/model/Category.dart';
import 'package:unit_converter/model/Unit.dart';

class UnitConverterRoute extends StatefulWidget {
  final Category category;

  const UnitConverterRoute({
    @required this.category,
  }) : assert(category != null);

  @override
  _UnitConverterRouteState createState() => _UnitConverterRouteState();
}

class _UnitConverterRouteState extends State<UnitConverterRoute> {
  Unit _fromUnit;
  Unit _toUnit;
  String _convertedValue = '';
  double _inputValue;
  bool _showValidationError = false;
  bool _showErrorUi = false;

  @override
  void initState() {
    super.initState();
    _setDefaults();
  }

  @override
  void didUpdateWidget(UnitConverterRoute oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.category != widget.category) {
      _setDefaults();
    }
  }

  void _setDefaults() {
    setState(() {
      _fromUnit = widget.category.units[0];
      _toUnit = widget.category.units[1];
    });
    if (_inputValue != null) {
      _updateConversion();
    }
  }

  /// Clean up conversion; trim trailing zeros, e.g. 5.500 -> 5.5, 10.0 -> 10
  String _format(double conversion) {
    var outputNum = conversion.toStringAsPrecision(7);
    if (outputNum.contains('.') && outputNum.endsWith('0')) {
      var i = outputNum.length - 1;
      while (outputNum[i] == '0') {
        i -= 1;
      }
      outputNum = outputNum.substring(0, i + 1);
    }
    if (outputNum.endsWith('.')) {
      return outputNum.substring(0, outputNum.length - 1);
    }
    return outputNum;
  }

  Future<void> _updateConversion() async {
    if (widget.category.name == apiCategory['name']) {
      final api = Api();
      final conversion = await api.convert(apiCategory['route'],
          _inputValue.toString(), _fromUnit.name, _toUnit.name);

      if (conversion == null) {
        setState(() {
          _showErrorUi = true;
        });
      } else {
        setState(() {
          _convertedValue = _format(conversion);
        });
      }
    } else {
      setState(() {
        _convertedValue =
            _format(_inputValue * (_toUnit.conversion / _fromUnit.conversion));
      });
    }
  }

  Unit _findUnit(String unitName) {
    return widget.category.units.firstWhere(
      (unit) => unit.name == unitName,
      orElse: null,
    );
  }

  void _updateFromConversion(dynamic unitName) {
    setState(() {
      _fromUnit = _findUnit(unitName);
    });

    if (_inputValue != null) {
      _updateConversion();
    }
  }

  void _updateToConversion(dynamic unitName) {
    setState(() {
      _toUnit = _findUnit(unitName);
    });

    if (_inputValue != null) {
      _updateConversion();
    }
  }

  void _updateInputValue(String input) {
    setState(() {
      if (input == null || input.isEmpty) {
        _convertedValue = '';
      } else {
        try {
          final inputDouble = double.parse(input);
          _showValidationError = false;
          _inputValue = inputDouble;
          _updateConversion();
        } catch (e) {
          print(e);
          _showValidationError = true;
        }
      }
    });
  }

  Widget _createDropdown(String currentValue, ValueChanged<dynamic> onChanged) {
    var newItems = <DropdownMenuItem>[];
    widget.category.units.forEach((unit) {
      newItems.add(DropdownMenuItem(
        value: unit.name,
        child: Container(
          child: Text(
            unit.name,
          ),
        ),
      ));
    });

    return Container(
      margin: EdgeInsets.only(top: 16.0),
      padding: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border.all(
          color: Colors.grey[400],
          width: 1.0,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton(
            value: currentValue,
            items: newItems,
            style: Theme.of(context).textTheme.title,
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.category.name == apiCategory['name'] && _showErrorUi) {
      return SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: widget.category.color,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.error_outline,
                size: 18.0,
                color: Colors.white,
              ),
              Text(
                'Connection Error!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline.copyWith(
                      color: Colors.white,
                    ),
              ),
            ],
          ),
        ),
      );
    }

    final input = Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextField(
            style: Theme.of(context).textTheme.display1,
            keyboardType: TextInputType.number,
            onChanged: _updateInputValue,
            decoration: InputDecoration(
              labelText: 'Input',
              labelStyle: Theme.of(context).textTheme.display1,
              errorText: _showValidationError ? 'Invalid number input' : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
            ),
          ),
          _createDropdown(_fromUnit.name, _updateFromConversion),
        ],
      ),
    );

    final arrows = RotatedBox(
      child: Icon(
        Icons.compare_arrows,
        size: 40.0,
      ),
      quarterTurns: 1,
    );

    final output = Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            InputDecorator(
              child: Text(
                _convertedValue,
                style: Theme.of(context).textTheme.display1,
              ),
              decoration: InputDecoration(
                labelText: "Output",
                labelStyle: Theme.of(context).textTheme.display1,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0.0),
                ),
              ),
            ),
            _createDropdown(_toUnit.name, _updateToConversion),
          ],
        ));

    final converter = ListView(
      children: <Widget>[
        input,
        arrows,
        output,
      ],
    );

    return Padding(
      padding: EdgeInsets.all(16.0),
      child: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          if (orientation == Orientation.portrait) {
            return converter;
          } else {
            return Center(
              child: Container(
                width: 450.0,
                child: converter,
              ),
            );
          }
        },
      ),
    );
  }
}
