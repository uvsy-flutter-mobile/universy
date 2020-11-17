import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optional/optional.dart';
import 'package:universy/constants/strings.dart';
import 'package:universy/model/lock.dart';
import 'package:universy/model/student/schedule.dart';
import 'package:universy/modules/student/schedule/bloc/cubit.dart';
import 'package:universy/text/text.dart';
import 'package:universy/util/object.dart';
import 'package:universy/widgets/buttons/uvsy/cancel.dart';
import 'package:universy/widgets/buttons/uvsy/save.dart';
import 'package:universy/widgets/dialog/title.dart';
import 'package:universy/widgets/formfield/decoration/builder.dart';
import 'package:universy/widgets/formfield/picker/month.dart';
import 'package:universy/widgets/formfield/text/custom.dart';
import 'package:universy/widgets/formfield/text/validators.dart';
import 'package:universy/widgets/paddings/edge.dart';

const double SEPARATOR_SPACE = 15;

class ScratchFormDialog extends StatefulWidget {
  final StudentScheduleScratch _studentScheduleScratch;
  final Function(StudentScheduleScratch) _onSave;
  final bool _create;

  ScratchFormDialog({
    StudentScheduleScratch studentScheduleScratch,
    Function(StudentScheduleScratch) onSave,
    bool create,
  })  : this._studentScheduleScratch = studentScheduleScratch,
        this._onSave = onSave,
        this._create = create,
        super();

  @override
  _ScratchFormDialogState createState() => _ScratchFormDialogState();
}

class _ScratchFormDialogState extends State<ScratchFormDialog> {
  StudentScheduleScratch _studentScheduleScratch;
  TextEditingController _nameTextController;
  bool _create;
  GlobalKey<FormState> _formKey;
  Function(StudentScheduleScratch) _onSave;
  bool _alert;
  final MAX_LENGTH_TITLE = 25;

  @override
  void initState() {
    this._onSave = widget._onSave;
    this._create = widget._create;
    this._alert = false;
    this._formKey = GlobalKey<FormState>();
    this._studentScheduleScratch =
        Optional.ofNullable(widget._studentScheduleScratch)
            .orElse(StudentScheduleScratch.empty());
    this._nameTextController = TextEditingController(
        text: widget._create
            ? EMPTY_STRING
            : widget._studentScheduleScratch.name);
    super.initState();
  }

  @override
  void dispose() {
    this._onSave = null;
    this._studentScheduleScratch = null;
    this._create = null;
    this._formKey = null;
    this._nameTextController.dispose();
    this._nameTextController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String title = _validateTitle();
    return TitleDialog(
      title: title,
      content: Container(
        padding: EdgeInsets.all(5),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildNameInput(),
              _buildTimeRange(context),
              _buildDateAlert()
            ],
          ),
        ),
      ),
      actions: <Widget>[
        SaveButton(onSave: () => _navigateToNext()),
        CancelButton(onCancel: () => Navigator.of(context).pop())
      ],
    );
  }

  Widget _buildDateAlert() {
    return Visibility(
        visible: _alert,
        child: Text(
          "Ingresá un rango de fechas válido",
          style: TextStyle(color: Colors.red, fontSize: 12.0),
        ));
  }

  void _navigateToNext() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      DateTime begin = new DateTime(_studentScheduleScratch.beginDate.year,
          _studentScheduleScratch.beginDate.month);
      DateTime end = new DateTime(_studentScheduleScratch.endDate.year,
          _studentScheduleScratch.endDate.month);
      if (begin.isBefore(end)) {
        setState(() {
          _alert = false;
        });
        this._studentScheduleScratch.name = _nameTextController.text;
        _onSave(this._studentScheduleScratch);
        Navigator.of(context).pop();
      } else {
        setState(() {
          _alert = true;
        });
      }
    }
  }

  String _validateTitle() {
    return _create
        ? AppText.getInstance()
            .get("student.schedule.scratchFormDialog.newScratchTitle")
        : AppText.getInstance()
            .get("student.schedule.scratchFormDialog.editScratchTitle");
  }

  Widget _buildNameInput() {
    return (SymmetricEdgePaddingWidget.vertical(
      paddingValue: 6.0,
      child: CustomTextFormField(
        controller: _nameTextController,
        validatorBuilder: TextFieldForumValidatorBuilder(
          AppText.getInstance().get("student.schedule.form.nameRequired"),
          AppText.getInstance().get("student.schedule.form.maxLength") +
              MAX_LENGTH_TITLE.toString(),
          MAX_LENGTH_TITLE,
        ),
        decorationBuilder: _getTitleInputDecoration(),
      ),
    ));
  }

  InputDecorationBuilder _getTitleInputDecoration() {
    return TextInputDecorationBuilder(AppText.getInstance()
        .get("student.schedule.scratchFormDialog.scratchTitle"));
  }

  Widget _buildTimeRange(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildBeginDate(),
            _buildMiddleDash(),
            _buildEndDate(),
          ],
        ));
  }

  Widget _buildBeginDate() {
    return Expanded(
      flex: 40,
      child: _buildDate(
        context: context,
        isBeginDate: true,
        date: _create ? DateTime.now() : _studentScheduleScratch.beginDate,
        label: AppText.getInstance()
            .get("student.schedule.scratchFormDialog.dateFrom"),
      ),
    );
  }

  Widget _buildMiddleDash() {
    return Expanded(
      flex: 20,
      child: Text(
        '-',
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 26),
      ),
    );
  }

  Widget _buildEndDate() {
    return Expanded(
      flex: 40,
      child: _buildDate(
        context: context,
        isBeginDate: false,
        date: _create ? DateTime.now() : _studentScheduleScratch.endDate,
        label: AppText.getInstance()
            .get("student.schedule.scratchFormDialog.dateTo"),
      ),
    );
  }

  Widget _buildDate(
      {@required BuildContext context,
      @required DateTime date,
      @required String label,
      bool isBeginDate}) {
    return SizedBox(
        width: 200,
        child: MonthPickerWidget(
          initialValue: date,
          context: context,
          label: label,
          onSaved: (value) => setState(() {
            isBeginDate
                ? _studentScheduleScratch.beginDate = value
                : _studentScheduleScratch.endDate = value;
          }),
        ));
  }
}
