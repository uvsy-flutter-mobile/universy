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
const int DEFAULT_TIME = 1603494929000; //TODO: change this

class ScratchFormDialog extends StatefulWidget {
  final StudentScheduleScratch _studentScheduleScratch;
  final ScheduleCubit _cubit;
  final bool _create;

  ScratchFormDialog({
    StudentScheduleScratch studentScheduleScratch,
    ScheduleCubit cubit,
    bool create,
  })  : this._studentScheduleScratch = studentScheduleScratch,
        this._create = create,
        this._cubit = cubit,
        super();

  @override
  _ScratchFormDialogState createState() => _ScratchFormDialogState();
}

class _ScratchFormDialogState extends State<ScratchFormDialog> {
  StudentScheduleScratch _studentScheduleScratch;
  TextEditingController _nameTextController;
  ScheduleCubit _cubit;
  bool _create;
  StateLock<StudentScheduleScratch> _stateLock;

  @override
  void initState() {
    this._create = widget._create;
    this._cubit = widget._cubit;
    this._studentScheduleScratch =
        Optional.ofNullable(widget._studentScheduleScratch)
            .orElse(StudentScheduleScratch.empty());
    this._stateLock = StateLock.lock(snapshot: widget._studentScheduleScratch);
    this._nameTextController = TextEditingController(
        text: widget._create
            ? EMPTY_STRING
            : widget._studentScheduleScratch.name);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isNull(_cubit)) {
      this._cubit = BlocProvider.of<ScheduleCubit>(context);
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    this._studentScheduleScratch = null;
    this._cubit = null;
    this._create = null;
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[_buildNameInput(), _buildTimeRange(context)],
        ),
      ),
      actions: <Widget>[
        SaveButton(onSave: () => _navigateToNext()),
        CancelButton(onCancel: () => Navigator.of(context).pop())
      ],
    );
  }

  void _navigateToNext() {
    if (_create) {
      _cubit.createViewScratchSchedule(_studentScheduleScratch);
      Navigator.pop(context);
    } else {
      _cubit.editViewScratchSchedule(_studentScheduleScratch);
      Navigator.pop(context);
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
    _nameTextController.addListener(_updateName);
    return (SymmetricEdgePaddingWidget.vertical(
      paddingValue: 6.0,
      child: CustomTextFormField(
        controller: _nameTextController,
        validatorBuilder: _getTitleInputValidator(),
        decorationBuilder: _getTitleInputDecoration(),
      ),
    ));
  }

  void _updateName() {
    _studentScheduleScratch.name = _nameTextController.text;
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
                isBeginDate: true,
                time: widget._create
                    ? DEFAULT_TIME
                    : _studentScheduleScratch.beginTime,
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
                isBeginDate: false,
                time: widget._create
                    ? DEFAULT_TIME
                    : _studentScheduleScratch.endTime,
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
      @required String label,
      bool isBeginDate}) {
    DateTime eventDate = DateTime.fromMillisecondsSinceEpoch(time);

    return SizedBox(
        width: 200,
        child: MonthPickerWidget(
          initialValue: eventDate,
          context: context,
          label: label,
          onSaved: (value) => setState(() {
            /*isBeginDate ? _studentScheduleScratch.beginTime = value : _studentScheduleScratch.endTime = value;*/
            //TODO convert DateTime to int
          }),
        ));
  }
}
