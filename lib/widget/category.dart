import 'package:flutter/material.dart';

const _rowHeight = 100.0;
const _borderRadius = 50.0;

class Category extends StatelessWidget {
  final IconData iconData;
  final String text;
  final Color rippleColor;

  const Category({this.iconData, this.text, this.rippleColor});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: _rowHeight,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
          highlightColor: rippleColor,
          splashColor: rippleColor,
          onTap: () {
            print('tapped');
          },
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(iconData),
                ),
                Center(
                  child: Text(text),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
