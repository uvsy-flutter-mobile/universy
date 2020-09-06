import 'package:flutter/material.dart';
import 'package:universy/modules/student/calendar/widget/form/keys.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/formfield/decoration/builder.dart';
import 'package:universy/widgets/formfield/text/custom.dart';
import 'package:universy/widgets/formfield/text/validators.dart';
import 'package:universy/widgets/paddings/edge.dart';

class StudentEventTitleWidget extends StatelessWidget {
  final TextEditingController _textEditingController;

  const StudentEventTitleWidget(
      {Key key, @required TextEditingController textEditingController})
      : this._textEditingController = textEditingController,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SymmetricEdgePaddingWidget.vertical(
      paddingValue: 6.0,
      child: CustomTextFormField(
        key: CALENDAR_KEY_TITLE,
        controller: _textEditingController,
        validatorBuilder: _getTitleInputValidator(),
        decorationBuilder: _getTitleInputDecoration(),
      ),
    );
  }

  InputDecorationBuilder _getTitleInputDecoration() {
    return TextInputDecorationBuilder(
        AppText.getInstance().get("student.calendar.form.eventTitle"));
  }

  TextFormFieldValidatorBuilder _getTitleInputValidator() {
    return NotEmptyTextFormFieldValidatorBuilder(_buildRequiredText());
  }

  String _buildRequiredText() =>
      AppText.getInstance().get("student.calendar.form.titleRequired");
}
