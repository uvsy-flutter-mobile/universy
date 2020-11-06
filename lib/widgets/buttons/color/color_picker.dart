import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerPicker extends StatelessWidget {
  final Color _initialColor;
  final Function(Color) _onSelectedColor;

  ColorPickerPicker({
    @required Color initialColor,
    @required Function(Color) onSelectedColor,
  })  : this._initialColor = initialColor,
        this._onSelectedColor = onSelectedColor,
        super();

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: _initialColor,
      child: IconButton(
        icon: Icon(
          Icons.palette,
          color: Colors.white,
        ),
        onPressed: () => _openColorPicker(context),
      ),
    );
  }

  void _openColorPicker(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: BlockPicker(
              pickerColor: _initialColor,
              onColorChanged: (Color newColor) {
                _onSelectedColor(newColor);
              },
            ),
          );
        });
  }
}
