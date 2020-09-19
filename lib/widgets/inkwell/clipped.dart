import 'package:flutter/material.dart';

class ClippedInkWell extends StatelessWidget {
  final Widget _child;
  final VoidCallback _onTap;
  final double _radius;
  final int _alpha;
  final Color _color;
  final Color _splashColor;

  ClippedInkWell(
      {@required Widget child,
      @required Color splashColor,
      @required VoidCallback onTap,
      double radius = 16.0,
      Color color = Colors.white,
      int alpha = 40})
      : this._alpha = alpha,
        this._radius = radius,
        this._child = child,
        this._splashColor = splashColor,
        this._onTap = onTap,
        this._color = color;

  @override
  Widget build(BuildContext context) {
    var borderRadius = BorderRadius.circular(_radius);
    return Material(
      color: _color,
      borderRadius: borderRadius,
      elevation: 2,
      child: ClipRRect(
        borderRadius: borderRadius,
        child: InkWell(
          splashColor: _splashColor.withAlpha(_alpha),
          onTap: _onTap,
          borderRadius: borderRadius,
          child: _child,
        ),
      ),
    );
  }
}
