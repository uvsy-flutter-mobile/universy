import 'package:flutter/material.dart';

class DeleteButton extends StatelessWidget {
  final VoidCallback _onDelete;
  final Color _splashColor;
  final double _size;

  const DeleteButton({
    Key key,
    VoidCallback onDelete,
    Color splashColor = Colors.redAccent,
    double size,
  })  : this._onDelete = onDelete,
        this._splashColor = splashColor,
        this._size = size,
        super(key: key);

  Widget build(BuildContext context) {
    return IconButton(
      splashColor: _splashColor,
      icon: Icon(Icons.delete, color: Color(0xFFF0446C)),
      onPressed: _onDelete,
      iconSize: _size,
    );
  }
}
