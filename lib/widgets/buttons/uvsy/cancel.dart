import 'package:flutter/material.dart';

class CancelButton extends StatelessWidget {
  final VoidCallback _onCancel;
  final Color _splashColor;

  const CancelButton({
    Key key,
    VoidCallback onCancel,
    Color splashColor = Colors.deepPurpleAccent,
  })  : this._onCancel = onCancel,
        this._splashColor = splashColor,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashColor: _splashColor,
      icon: Icon(Icons.cancel, color: Color(0xFf737373), size: 40.0),
      onPressed: _onCancel,
    );
  }
}
