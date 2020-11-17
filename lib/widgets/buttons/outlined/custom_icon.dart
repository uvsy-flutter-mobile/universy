import 'package:flutter/material.dart';
import 'package:universy/widgets/buttons/raised/shaped.dart';

class CustomOutlinedButtonIcon extends StatelessWidget {
  final Function onPressed;
  final double padding;
  final double borderRadius;
  final double borderWidth;
  final Color color;
  final String labelText;
  final TextStyle buttonTextStyle;
  final IconData iconData;

  CustomOutlinedButtonIcon({
    @required this.color,
    @required this.labelText,
    @required this.iconData,
    @required this.onPressed,
    this.buttonTextStyle,
    this.padding = 10,
    this.borderRadius = 8,
    this.borderWidth = 4,
  });

  @override
  Widget build(BuildContext context) {
    return OutlineButton.icon(
      onPressed: onPressed,
      padding: EdgeInsets.all(padding),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      borderSide: BorderSide(
        width: borderWidth,
        color: color,
      ),
      color: color,
      label: Text(
        labelText,
        style: buttonTextStyle.copyWith(
          color: color,
        ),
      ),
      icon: Icon(
        iconData,
        color: color,
      ),
    );
  }
}
