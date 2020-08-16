import 'package:flutter/material.dart';

class CancelButton extends StatelessWidget {
  final VoidCallback _onCancel;
  final Color _splashColor;
  final Color _iconColor;

  const CancelButton({
    Key key,
    VoidCallback onCancel,
    Color splashColor = Colors.deepPurpleAccent,
    Color iconColor = Colors.deepPurple,
  })  : this._onCancel = onCancel,
        this._splashColor = splashColor,
        this._iconColor = iconColor,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashColor: _splashColor,
      icon: Icon(Icons.cancel, color: _iconColor, size: 40.0),
      onPressed: _onCancel,
    );
  }
}
