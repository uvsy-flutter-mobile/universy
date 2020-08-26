import 'package:card_settings/widgets/card_settings_widget.dart';
import 'package:card_settings/widgets/picker_fields/card_settings_time_picker.dart';
import 'package:flutter/material.dart';

class StudentEventTimeWidget extends StatelessWidget
    implements CardSettingsWidget {
  final String label;
  final TimeOfDay initialTime;
  final Function(TimeOfDay) onChange;
  final Function(TimeOfDay) onSave;

  const StudentEventTimeWidget(
      {Key key, this.label, this.initialTime, this.onChange, this.onSave})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardSettingsTimePicker(
      key: GlobalKey(),
      contentAlign: TextAlign.right,
      label: label,
      initialValue: initialTime,
      icon: Icon(Icons.access_time),
      onChanged: onChange,
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
