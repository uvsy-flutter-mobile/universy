import 'package:card_settings/widgets/card_settings_widget.dart';
import 'package:card_settings/widgets/picker_fields/card_settings_time_picker.dart';
import 'package:flutter/material.dart';

class StudentCalendarFormActionsWidget extends StatelessWidget
    implements CardSettingsWidget {
  final BuildContext context;
  final Function pressSaveEventButton;

  const StudentCalendarFormActionsWidget(
      {Key key, this.context, this.pressSaveEventButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _buildSaveButton(),
        _buildCancelButton(),
      ],
    );
  }

  Widget _buildSaveButton() {
    return IconButton(
        splashColor: Colors.amber,
        icon:
            Icon(Icons.check_circle_outline, color: Colors.orange, size: 35.0),
        onPressed: () => pressSaveEventButton());
  }

  Widget _buildCancelButton() {
    return IconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      splashColor: Colors.amber,
      icon: Icon(Icons.cancel, color: Colors.orange, size: 35.0),
    );
  }

  @override
  // TODO: implement showMaterialonIOS
  bool get showMaterialonIOS => throw UnimplementedError();

  @override
  // TODO: implement visible
  bool get visible => true;
}
