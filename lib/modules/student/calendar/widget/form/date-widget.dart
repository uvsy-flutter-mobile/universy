import 'package:card_settings/card_settings.dart';
import 'package:flutter/material.dart';
import 'package:universy/text/text.dart';

class StudentEventDateWidget extends StatelessWidget
    implements CardSettingsWidget {
  final DateTime initialDate;
  final Function(DateTime) onSave;

  const StudentEventDateWidget({Key key, this.initialDate, this.onSave})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardSettingsDatePicker(
      label: AppText.getInstance().get("student.calendar.form.eventDate"),
      contentAlign: TextAlign.right,
      firstDate: initialDate.subtract(Duration(days: 365 * 3)),
      visible: true,
      onSaved: onSave,
    );
  }

  @override
  // TODO: implement showMaterialonIOS
  bool get showMaterialonIOS => throw UnimplementedError();

  @override
  // TODO: implement visible
  bool get visible => true;
}
