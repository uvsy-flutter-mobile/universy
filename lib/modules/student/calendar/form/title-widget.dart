import 'package:card_settings/card_settings.dart';
import 'package:flutter/material.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/formfield/text/validators.dart';

class StudentEventTitleWidget extends StatelessWidget {
  final String initialValue;
  final Function(String) onSaved;

  const StudentEventTitleWidget({Key key, this.initialValue, this.onSaved})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardSettingsText(
      textCapitalization: TextCapitalization.sentences,
      hintText: _buildHintText(),
      label: _buildHintText(),
      initialValue: initialValue,
      contentAlign: TextAlign.right,
      style: TextStyle(fontStyle: FontStyle.normal, color: Colors.black),
      onSaved: onSaved,
      validator: NotEmptyTextFormFieldValidatorBuilder(_buildRequiredText())
          .build(context),
    );
  }

  String _buildRequiredText() =>
      AppText.getInstance().get("studentEvents.eventForm.titleRequired");

  String _buildHintText() =>
      AppText.getInstance().get("studentEvents.eventForm.eventTitle");
}
