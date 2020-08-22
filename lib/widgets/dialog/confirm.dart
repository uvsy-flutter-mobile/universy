import 'package:flutter/material.dart';
import 'package:universy/text/text.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String content;

  const ConfirmDialog({Key key, this.title, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(AppText.getInstance().get("general.no")),
        ),
        FlatButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(AppText.getInstance().get("general.yes")),
        ),
      ],
    );
  }
}
