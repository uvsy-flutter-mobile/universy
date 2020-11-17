import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:universy/widgets/buttons/uvsy/save.dart';

class ColorPickerButton extends StatelessWidget {
  final Color _initialColor;
  final Function(Color) _onSelectedColor;
  final double _radius;
  final double _iconSize;

  ColorPickerButton({
    @required Color initialColor,
    @required Function(Color) onSelectedColor,
    double radius = 24,
    double iconSize = 28,
  })  : this._initialColor = initialColor,
        this._onSelectedColor = onSelectedColor,
        this._radius = radius,
        this._iconSize = iconSize,
        super();

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: _initialColor,
      radius: _radius,
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(
          Icons.palette,
          color: Colors.white,
          size: _iconSize,
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
            actionsPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            actions: <Widget>[
              SaveButton(
                onSave: () => Navigator.of(context).pop(true),
              )
            ],
          );
        });
  }
}
