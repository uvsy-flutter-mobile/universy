import 'package:flutter/material.dart';
import 'package:universy/widgets/buttons/uvsy/cancel.dart';
import 'package:universy/widgets/buttons/uvsy/save.dart';

class StudentCalendarFormActionsWidget extends StatelessWidget {
  final BuildContext context;
  final Function pressSaveEventButton;

  const StudentCalendarFormActionsWidget(
      {Key key, this.context, this.pressSaveEventButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SaveButton(onSave: pressSaveEventButton),
        CancelButton(onCancel: () => Navigator.of(context).pop()),
      ],
    );
  }
}
