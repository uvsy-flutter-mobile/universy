import 'package:flutter/material.dart';
import 'package:universy/widgets/cards/shaped.dart';

class RoundedRectangleCard extends ShapedCard {
  RoundedRectangleCard(
      BorderRadiusGeometry borderRadius, Color color, Widget child,
      {Key key})
      : super(_getShape(borderRadius), color, child, key: key);

  static ShapeBorder _getShape(BorderRadiusGeometry borderRadius) {
    return RoundedRectangleBorder(borderRadius: borderRadius);
  }
}

class CircularRoundedRectangleCard extends RoundedRectangleCard {
  CircularRoundedRectangleCard(
      {@required double radius,
      @required Color color,
      @required Widget child,
      Key key})
      : super(_getBorderRadiusGeometry(radius), color, child, key: key);

  static BorderRadiusGeometry _getBorderRadiusGeometry(double radius) {
    return BorderRadius.circular(radius);
  }
}
