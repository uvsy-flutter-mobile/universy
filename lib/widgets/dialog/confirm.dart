import 'package:flutter/material.dart';
import 'package:universy/text/text.dart';
import 'package:universy/util/object.dart';
import 'package:universy/widgets/buttons/uvsy/cancel.dart';
import 'package:universy/widgets/buttons/uvsy/save.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String content;
  final List<Widget> buttons;

  const ConfirmDialog({Key key, this.title, this.content, this.buttons})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: _buildShape(),
        title: Text(title),
        content: Text(content),
        actions: notNull(buttons)
            ? buttons
            : [
                SaveButton(onSave: () => Navigator.of(context).pop(true)),
                CancelButton(onCancel: () => Navigator.of(context).pop(false))
              ]);
  }

  ShapeBorder _buildShape() {
    return RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0)));
  }
}
