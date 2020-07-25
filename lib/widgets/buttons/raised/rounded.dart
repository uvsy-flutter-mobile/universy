import 'package:flutter/material.dart';
import 'package:universy/widgets/buttons/raised/shaped.dart';

/// This widget abstracts a raised button with a
/// rectangle-like shape with rounded borders
class RoundedRectangleRaisedButton extends ShapedRaisedButton {
  RoundedRectangleRaisedButton(
      {@required BorderRadiusGeometry borderRadius,
      @required VoidCallback onPressed,
      @required Color color,
      @required Widget child,
      Key key})
      : super(_getShape(borderRadius), onPressed, color, child, key: key);

  static ShapeBorder _getShape(BorderRadiusGeometry borderRadius) {
    return RoundedRectangleBorder(borderRadius: borderRadius);
  }
}

/// This widget abstracts a raised button with a
/// rectangle-like shape with rounded borders
/// added with a circular geometry on the borders
class CircularRoundedRectangleRaisedButton
    extends RoundedRectangleRaisedButton {
  CircularRoundedRectangleRaisedButton.text(
      {@required double radius,
      @required onPressed,
      @required Color color,
      @required String text,
      @required TextStyle textStyle,
      Key key})
      : super(
            borderRadius: _getBorderRadiusGeometry(radius),
            onPressed: onPressed,
            color: color,
            child: _getTextWidget(text, textStyle),
            key: key);

  CircularRoundedRectangleRaisedButton.general(
      {@required double radius,
      @required onPressed,
      @required Color color,
      @required Widget child,
      Key key})
      : super(
            borderRadius: _getBorderRadiusGeometry(radius),
            onPressed: onPressed,
            color: color,
            child: child,
            key: key);

  static BorderRadiusGeometry _getBorderRadiusGeometry(double radius) {
    return BorderRadius.circular(radius);
  }

  static Text _getTextWidget(String text, TextStyle textStyle) {
    return Text(text, style: textStyle);
  }
}
