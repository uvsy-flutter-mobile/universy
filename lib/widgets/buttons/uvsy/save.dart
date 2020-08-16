import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  final VoidCallback _onSave;
  final Color _splashColor;

  const SaveButton({
    Key key,
    VoidCallback onSave,
    Color splashColor = Colors.deepPurpleAccent,
  })  : this._onSave = onSave,
        this._splashColor = splashColor,
        super(key: key);

  Widget build(BuildContext context) {
    return IconButton(
      splashColor: _splashColor,
      icon: Icon(Icons.check_circle, color: Theme.of(context).buttonColor, size: 40.0),
      onPressed: _onSave,
    );
  }
}
