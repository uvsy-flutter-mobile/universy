import 'package:flutter/material.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/formfield/decoration/builder.dart';
import 'package:universy/widgets/formfield/text/custom.dart';
import 'package:universy/widgets/formfield/text/validators.dart';
import 'package:universy/widgets/paddings/edge.dart';

class StudentEventTimeWidget extends StatefulWidget {
  final String label;
  final TimeOfDay selectedTime;
  final Function(TimeOfDay) onChange;

  const StudentEventTimeWidget(
      {Key key, this.label, this.selectedTime, this.onChange})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return StudentEventTimeState(key, label, selectedTime, onChange);
  }
}

class StudentEventTimeState extends State<StudentEventTimeWidget> {
  Key _key;
  TextEditingController _textEditingController;
  String _label;
  TimeOfDay _selectedTime;
  Function(TimeOfDay) _onChange;

  StudentEventTimeState(
      this._key, this._label, this._selectedTime, this._onChange);

  @override
  void didChangeDependencies() {
    this._textEditingController =
        TextEditingController(text: _selectedTime.format(context));
    this._textEditingController.addListener(() {
      _onChange(_selectedTime);
    });
    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        TimeOfDay picked = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
          builder: (BuildContext context, Widget child) {
            return MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child,
            );
          },
        );
        _textEditingController.text = picked.format(context);
        _selectedTime = picked;
      },
      child: SymmetricEdgePaddingWidget.vertical(
        paddingValue: 6.0,
        child: CustomTextFormField(
          key: this._key,
          enabled: false,
          controller: _textEditingController,
          validatorBuilder: _getTitleInputValidator(),
          decorationBuilder: _getTitleInputDecoration(),
        ),
      ),
    );
  }

  InputDecorationBuilder _getTitleInputDecoration() {
    return TextInputDecorationBuilder(_label);
  }

  TextFormFieldValidatorBuilder _getTitleInputValidator() {
    return NotEmptyTextFormFieldValidatorBuilder(_buildRequiredText());
  }

  String _buildRequiredText() =>
      AppText.getInstance().get("student.calendar.form.titleRequired");

//  Widget build(BuildContext context) {
//    return GestureDetector(
//        onTap: () async {
//          TimeOfDay picked = await showTimePicker(
//            context: context,
//            initialTime: TimeOfDay.now(),
//            builder: (BuildContext context, Widget child) {
//              return MediaQuery(
//                data: MediaQuery.of(context)
//                    .copyWith(alwaysUse24HourFormat: true),
//                child: child,
//              );
//            },
//          );
//        },
//        child: Text(
//          "SetTime",
//          textAlign: TextAlign.center,
//        ));
//  }
}
