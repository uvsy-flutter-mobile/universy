import 'package:flutter/material.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/formfield/decoration/builder.dart';
import 'package:universy/widgets/formfield/text/custom.dart';
import 'package:universy/widgets/formfield/text/validators.dart';
import 'package:universy/widgets/paddings/edge.dart';

class StudentEventDateWidget extends StatefulWidget {
  final String label;
  final DateTime selectedDate;
  final Function(DateTime) onChange;

  const StudentEventDateWidget(
      {Key key, this.label, this.selectedDate, this.onChange})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return StudentEventDateState(key, label, selectedDate, onChange);
  }
}

class StudentEventDateState extends State<StudentEventDateWidget> {
  Key _key;
  TextEditingController _textEditingController;
  String _label;
  DateTime _selectedDate;
  Function(DateTime) _onChange;

  StudentEventDateState(
      this._key, this._label, this._selectedDate, this._onChange);

  @override
  void didChangeDependencies() {
    this._textEditingController =
        TextEditingController(text: _selectedDate.toString());
    this._textEditingController.addListener(() {
      _onChange(_selectedDate);
    });
    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleOnTap,
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

  void handleOnTap() async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child,
        );
      },
    );
    setState(() {
      _textEditingController.text = picked.toString();
      _selectedDate = picked;
    });
  }

  InputDecorationBuilder _getTitleInputDecoration() {
    return TextInputDecorationBuilder(_label);
  }

  TextFormFieldValidatorBuilder _getTitleInputValidator() {
    return NotEmptyTextFormFieldValidatorBuilder(_buildRequiredText());
  }

  String _buildRequiredText() =>
      AppText.getInstance().get("student.calendar.form.titleRequired");
}
