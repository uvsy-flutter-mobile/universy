import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universy/text/text.dart';

class ExitDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppText.getInstance().get("general.exit.title")),
      content: Text(AppText.getInstance().get("general.exit.content")),
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
