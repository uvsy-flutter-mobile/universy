import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/buttons/raised/rounded.dart';
import 'package:universy/widgets/buttons/uvsy/cancel.dart';

import 'confirm.dart';

class ExitDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConfirmDialog(
      title: AppText.getInstance().get("general.exit.title"),
      content: AppText.getInstance().get("general.exit.content"),
      buttons: <Widget>[
        CircularRoundedRectangleRaisedButton.text(
          text: "Salir",
          textStyle: Theme.of(context).primaryTextTheme.button,
          color: Theme.of(context).accentColor,
          radius: 10,
          onPressed: () => Navigator.of(context).pop(true),
        ),
        CancelButton(
          onCancel: () => Navigator.of(context).pop(false),
        )
      ],
    );
  }
}
