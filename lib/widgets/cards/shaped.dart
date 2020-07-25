import 'package:flutter/material.dart';

class ShapedCard extends StatelessWidget {
  final Widget _child;
  final ShapeBorder _shapeBorder;
  final Color _color;
  final Key _key;

  const ShapedCard(this._shapeBorder, this._color, this._child, {Key key})
      : this._key = key;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: _shapeBorder,
      color: _color,
      child: _child,
      key: _key,
    );
  }
}
