import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:universy/model/student/schedule.dart';
import 'package:universy/text/text.dart';
import 'package:universy/util/object.dart';
import 'package:universy/widgets/buttons/uvsy/cancel.dart';
import 'package:universy/widgets/buttons/uvsy/save.dart';
import 'package:universy/widgets/dialog/title.dart';
import 'package:universy/widgets/formfield/decoration/builder.dart';
import 'package:universy/widgets/formfield/picker/date.dart';
import 'package:universy/widgets/formfield/picker/month.dart';
import 'package:universy/widgets/formfield/text/custom.dart';
import 'package:universy/widgets/formfield/text/validators.dart';
import 'package:universy/widgets/paddings/edge.dart';

import '../scratch_view.dart';

const double SEPARATOR_SPACE = 15;
const int DEFAULT_TIME = 1603494929000; //TODO: change this

class ScratchFormDialog extends StatelessWidget {
  final StudentScheduleScratch _studentScheduleScratch;
  final TextEditingController _textEditingController;

  ScratchFormDialog({
    StudentScheduleScratch studentScheduleScratch,
  })  : this._studentScheduleScratch = studentScheduleScratch,
        this._textEditingController = TextEditingController(),
        super();

  @override
  Widget build(BuildContext context) {
    String title = notNull(this._studentScheduleScratch)
        ? AppText.getInstance()
            .get("student.schedule.scratchFormDialog.editScratchTitle")
        : AppText.getInstance()
            .get("student.schedule.scratchFormDialog.newScratchTitle");

    return TitleDialog(
      title: title,
      content: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[_buildNameInput(), _buildTimeRange(context)],
        ),
      ),
      actions: <Widget>[
        SaveButton(onSave: () => ScratchView(create: true)),
        CancelButton(onCancel: () => Navigator.of(context).pop())
      ],
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
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 40,
              child: _buildDate(
                context: context,
                time: _studentScheduleScratch?.endTime ?? DEFAULT_TIME,
                label: AppText.getInstance()
                    .get("student.schedule.scratchFormDialog.dateFrom"),
              ),
            ),
            Expanded(
              flex: 20,
              child: Text(
                '-',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 26),
              ),
            ),
            Expanded(
              flex: 40,
              child: _buildDate(
                context: context,
                time: _studentScheduleScratch?.endTime ?? DEFAULT_TIME,
                label: AppText.getInstance()
                    .get("student.schedule.scratchFormDialog.dateTo"),
              ),
            ),
          ],
        ));
  }

  Widget _buildDate(
      {@required BuildContext context,
      @required int time,
      @required String label}) {
    DateTime eventDate = DateTime.fromMillisecondsSinceEpoch(time);

    return SizedBox(
        width: 200,
        child: MonthPickerWidget(
          initialValue: eventDate,
          context: context,
          label: label,
          onSaved: (value) => print('new value $value'),
        ));
  }
}
