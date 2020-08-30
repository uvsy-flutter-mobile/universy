import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universy/text/text.dart';

import 'confirm.dart';

class ExitDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConfirmDialog(
      title: AppText.getInstance().get("general.exit.title"),
      content: AppText.getInstance().get("general.exit.content"),
    );
  }
}
