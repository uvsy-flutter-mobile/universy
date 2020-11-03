import 'package:flutter/material.dart';
import 'package:universy/widgets/cards/shaped.dart';

class RoundedRectangleCard extends ShapedCard {
  RoundedRectangleCard(
      BorderRadiusGeometry borderRadius, Color color, Widget child,
      {double elevation, Key key, Color borderColor})
      : super(_getShape(borderRadius, borderColor: borderColor), color, child,
            elevation: elevation, key: key);

  static ShapeBorder _getShape(BorderRadiusGeometry borderRadius,
      {Color borderColor = Colors.transparent}) {
    return RoundedRectangleBorder(
        borderRadius: borderRadius,
        side: BorderSide(color: borderColor, width: 4));
  }
}

class CircularRoundedRectangleCard extends RoundedRectangleCard {
  CircularRoundedRectangleCard(
      {@required double radius,
      @required Color color,
      @required Widget child,
      Color borderColor,
      double elevation,
      Key key})
      : super(_getBorderRadiusGeometry(radius), color, child,
            elevation: elevation, key: key, borderColor: borderColor);

  static BorderRadiusGeometry _getBorderRadiusGeometry(double radius) {
    return BorderRadius.circular(radius);
  }
}
