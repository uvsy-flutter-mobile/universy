import 'package:flutter/material.dart';

class ShapedCard extends StatelessWidget {
  final Widget _child;
  final ShapeBorder _shapeBorder;
  final Color _color;
  final Key _key;
  final double _elevation;

  const ShapedCard(this._shapeBorder, this._color, this._child,
      {double elevation, Key key})
      : this._key = key,
        this._elevation = elevation ?? 1.0;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: _elevation,
      shape: _shapeBorder,
      color: _color,
      child: _child,
      key: _key,
    );
  }
}
