import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:universy/model/student/schedule.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/formfield/decoration/builder.dart';
import 'package:universy/widgets/formfield/picker/date.dart';
import 'package:universy/widgets/formfield/text/custom.dart';
import 'package:universy/widgets/formfield/text/validators.dart';
import 'package:universy/widgets/paddings/edge.dart';

const double SEPARATOR_SPACE = 15;

class ScratchForm extends StatelessWidget {
  final StudentScheduleScratch _studentScheduleScratch;
  final TextEditingController _textEditingController;
  ScratchForm({
    StudentScheduleScratch studentScheduleScratch,
  })  : this._studentScheduleScratch = studentScheduleScratch,
        this._textEditingController = TextEditingController(),
        super();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[_buildNameInput(), _buildTimeRange(context)],
      ),
    );
  }

  Widget _buildNameInput() {
    return (SymmetricEdgePaddingWidget.vertical(
      paddingValue: 6.0,
      child: CustomTextFormField(
        controller: _textEditingController,
        validatorBuilder: _getTitleInputValidator(),
        decorationBuilder: _getTitleInputDecoration(),
      ),
    ));
  }

  TextFormFieldValidatorBuilder _getTitleInputValidator() {
    return NotEmptyTextFormFieldValidatorBuilder(_buildRequiredText());
  }

  InputDecorationBuilder _getTitleInputDecoration() {
    return TextInputDecorationBuilder(
        AppText.getInstance().get("student.calendar.form.eventTitle"));
  }

  String _buildRequiredText() =>
      AppText.getInstance().get("student.calendar.form.titleRequired");

  Widget _buildTimeRange(BuildContext context) {
    return SizedBox(
        width: 200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 60,
              child: _buildDate(
                  context, _studentScheduleScratch?.beginTime ?? 1603494929),
            ),
            SizedBox(
              width: 5,
              child: Text(
                '-',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 26),
              ),
            ),
            SizedBox(
              width: 60,
              child: _buildDate(
                  context, _studentScheduleScratch?.endTime ?? 1603494929),
            ),
          ],
        ));
  }

  Widget _buildDate(BuildContext context, double time) {
    DateTime eventDate = DateTime.fromMillisecondsSinceEpoch(1603494929000);
    String label = AppText.getInstance().get("student.calendar.form.eventDate");

    return SizedBox(
        width: 200,
        child: DatePickerWidget(
          initialValue: eventDate,
          context: context,
          label: label,
          onSaved: (value) => print('new value $value'),
        ));
  }
}
