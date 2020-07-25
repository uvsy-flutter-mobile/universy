import 'package:flutter/material.dart';

class ShapedRaisedButton extends StatelessWidget {
  final ShapeBorder _shape;
  final VoidCallback _onPressed;
  final Widget _child;
  final Color _color;
  final Key _key;

  const ShapedRaisedButton(
      this._shape, this._onPressed, this._color, this._child,
      {Key key})
      : this._key = key;

  Widget build(BuildContext context) {
    return RaisedButton(
      shape: _shape,
      onPressed: _onPressed,
      child: _child,
      color: _color,
      key: _key,
    );
  }
}
