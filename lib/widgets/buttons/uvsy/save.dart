import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  final VoidCallback _onSave;
  final Color _splashColor;
  final Color _iconColor;

  const SaveButton({
    Key key,
    VoidCallback onSave,
    Color splashColor = Colors.amber,
    Color iconColor = Colors.orange,
  })  : this._onSave = onSave,
        this._splashColor = splashColor,
        this._iconColor = iconColor,
        super(key: key);

  Widget build(BuildContext context) {
    return IconButton(
      splashColor: _splashColor,
      icon: Icon(Icons.check_circle_outline, color: _iconColor, size: 35.0),
      onPressed: _onSave,
    );
  }
}
