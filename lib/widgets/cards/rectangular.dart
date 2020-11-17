import 'package:flutter/material.dart';
import 'package:universy/widgets/cards/shaped.dart';

class RoundedRectangleCard extends ShapedCard {
  RoundedRectangleCard(
      BorderRadiusGeometry borderRadius, Color color, Widget child,
      {double elevation, Key key, Color borderColor = Colors.transparent})
      : super(_getShape(borderRadius, borderColor), color, child,
            elevation: elevation, key: key);

  static ShapeBorder _getShape(
      BorderRadiusGeometry borderRadius, Color borderColor) {
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
      Color borderColor = Colors.transparent,
      double elevation,
      Key key})
      : super(_getBorderRadiusGeometry(radius), color, child,
            elevation: elevation, key: key, borderColor: borderColor);

  static BorderRadiusGeometry _getBorderRadiusGeometry(double radius) {
    return BorderRadius.circular(radius);
  }
}
