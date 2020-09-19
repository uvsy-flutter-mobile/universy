import 'package:flutter/material.dart';
import 'package:optional/optional.dart';
import 'package:provider/provider.dart';
import 'package:universy/constants/event-types.dart';
import 'package:universy/model/student/event.dart';
import 'package:universy/modules/student/calendar/widget/form/calendar-actions.dart';
import 'package:universy/modules/student/calendar/widget/form/description-widget.dart';
import 'package:universy/modules/student/calendar/widget/form/event-type.dart';
import 'package:universy/modules/student/calendar/widget/form/title-widget.dart';
import 'package:universy/services/factory.dart';
import 'package:universy/services/manifest.dart';
import 'package:universy/text/text.dart';
import 'package:universy/util/save-lock.dart';
import 'package:universy/widgets/async/modal.dart';
import 'package:universy/widgets/formfield/picker/date-widget.dart';
import 'package:universy/widgets/formfield/picker/time-widget.dart';
import 'package:universy/widgets/formfield/text/validators.dart';

const EMPTY_STRING = "";

class StudentEventFormWidget extends StatefulWidget {
  final StudentEvent _studentEvent;
  final DateTime _daySelected;
  final Function() _onConfirm;

  StudentEventFormWidget({
    Key key,
    StudentEvent studentEvent,
    DateTime daySelected,
    @required Function() onConfirm,
  })  : this._daySelected = daySelected,
        this._studentEvent = studentEvent,
        this._onConfirm = onConfirm,
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return StudentEventFormWidgetState();
  }
}

class StudentEventFormWidgetState extends State<StudentEventFormWidget> {
  DateTime _daySelected;
  GlobalKey<FormState> _formKey;
  StudentEvent _studentEvent;
  TimeOfDay _timeFrom;
  TimeOfDay _timeTo;
  StudentEventService _studentEventService;
  TextEditingController _titleTextEditingController;
  TextEditingController _descriptionTextEditingController;

  SaveLock<StudentEvent> _saveLock;

  void initState() {
    this._daySelected = widget._daySelected;
    this._formKey = GlobalKey<FormState>();
    this._studentEvent =
        Optional.ofNullable(widget._studentEvent).orElse(StudentEvent.empty());
    this._timeFrom =
        Optional.ofNullable(_studentEvent.timeFrom).orElse(TimeOfDay.now());
    this._timeTo =
        Optional.ofNullable(_studentEvent.timeTo).orElse(TimeOfDay.now());
    this._saveLock = SaveLock.lock(snapshot: widget._studentEvent);
    this._titleTextEditingController =
        TextEditingController(text: _studentEvent.title ?? EMPTY_STRING);
    this._descriptionTextEditingController =
        TextEditingController(text: _studentEvent.description ?? EMPTY_STRING);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    var sessionFactory = Provider.of<ServiceFactory>(context, listen: false);
    this._studentEventService = sessionFactory.studentEventService();
    if (this._titleTextEditingController.text == EMPTY_STRING) {
      this._titleTextEditingController.text =
          AppText.getInstance().get("student.calendar.form.title");
    }
    super.didChangeDependencies();
  }

  void dispose() {
    this._daySelected = null;
    this._formKey = null;
    this._studentEvent = null;
    this._timeFrom = null;
    this._timeTo = null;
    this._studentEventService = null;
    this._titleTextEditingController.dispose();
    this._titleTextEditingController = null;
    this._descriptionTextEditingController.dispose();
    this._descriptionTextEditingController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildNewEventAppBar(),
      body: _buildNewEventBody(),
    );
  }

  Widget _buildNewEventAppBar() {
    var appBarText = _studentEvent.isNewEvent
        ? AppText.getInstance().get("student.calendar.form.title")
        : AppText.getInstance().get("student.calendar.form.editTitle");

    return AppBar(title: Text(appBarText));
  }

  Widget _buildNewEventBody() {
    return Theme(
      data: Theme.of(context),
      child: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(30.0),
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTitle(),
                _buildDate(),
                _buildTimeRange(context),
                SizedBox(
                  height: 25,
                ),
                _buildEventTypePicker(),
                _buildDescriptionText(),
                _buildActionButtons()
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    _titleTextEditingController.addListener(_titleOnSave);
    return SizedBox(
        width: 200,
        child: StudentEventTitleWidget(
          textEditingController: _titleTextEditingController,
        ));
  }

  void _titleOnSave() {
    this._studentEvent.title = this._titleTextEditingController.text;
  }

  Widget _buildDate() {
    DateTime eventDate = Optional.ofNullable(_studentEvent)
        .map(
          (event) => event.date,
        )
        .orElse(_daySelected);
    String requiredText =
        AppText.getInstance().get("student.calendar.form.eventDateRequired");
    String label = AppText.getInstance().get("student.calendar.form.eventDate");
    void _dateOnSave(DateTime selectedDate) {
      this._studentEvent.date = selectedDate;
    }

    return SizedBox(
        width: 200,
        child: StudentEventDateWidget(
          validatorBuilder: NotEmptyTextFormFieldValidatorBuilder(requiredText),
          initialValue: eventDate,
          context: context,
          label: label,
          onSaved: _dateOnSave,
        ));
  }

  Widget _buildTimeRange(BuildContext context) {
    return SizedBox(
        width: 200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 60,
              child: _buildTimeFrom(context),
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
              child: _buildTimeTo(context),
            ),
          ],
        ));
  }

  Widget _buildTimeFrom(BuildContext context) {
    String requiredText =
        AppText.getInstance().get("student.calendar.form.timeFromRequired");
    String label = AppText.getInstance().get("student.calendar.form.timeFrom");
    void _timeFromOnSave(TimeOfDay selectedTime) {
      _studentEvent.timeFrom = selectedTime;
    }

    return StudentEventTimeWidget(
        validatorBuilder: NotEmptyTextFormFieldValidatorBuilder(requiredText),
        label: label,
        initialValue: _timeFrom,
        context: context,
        onSaved: _timeFromOnSave);
  }

  Widget _buildTimeTo(BuildContext context) {
    String requiredText =
        AppText.getInstance().get("student.calendar.form.timeToRequired");
    String label = AppText.getInstance().get("student.calendar.form.timeTo");
    void _timeToOnSave(TimeOfDay selectedTime) {
      _studentEvent.timeTo = selectedTime;
    }

    return StudentEventTimeWidget(
      context: context,
      validatorBuilder: NotEmptyTextFormFieldValidatorBuilder(requiredText),
      label: label,
      initialValue: _timeTo,
      onSaved: _timeToOnSave,
    );
  }

  Widget _buildEventTypePicker() {
    String eventType = _studentEvent.eventType ?? EventType.FINAL_EXAM;
    String sectionTitle =
        AppText.getInstance().get("student.calendar.form.eventTypeTitle");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          sectionTitle,
          textAlign: TextAlign.left,
          style: Theme.of(context).inputDecorationTheme.labelStyle,
        ),
        SizedBox(
          height: 8,
        ),
        SizedBox(
            height: 185,
            child: StudentEventTypeWidget(
              onChange: _onEventTypeChange,
              eventType: eventType,
            ))
      ],
    );
  }

  void _onEventTypeChange(String eventType) {
    _studentEvent.eventType = eventType;
  }

  Widget _buildDescriptionText() {
    _descriptionTextEditingController.addListener(_descriptionOnSave);
    return StudentEventDescriptionWidget(
      textEditingController: _descriptionTextEditingController,
      label: AppText.getInstance().get("student.calendar.form.description"),
      descriptionLabel:
          AppText.getInstance().get("student.calendar.form.descriptionCheck"),
    );
  }

  void _descriptionOnSave() {
    this._studentEvent.description = _descriptionTextEditingController.text;
  }

  Widget _buildActionButtons() {
    return StudentCalendarFormActionsWidget(
      context: context,
      pressSaveEventButton: _pressConfirmButton,
    );
  }

  void _pressConfirmButton() async {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();

      if (_saveLock.shouldSave(_studentEvent)) {
        var confirmAction =
            this._studentEvent.isNewEvent ? _saveEvent : _updateEvent;

        await AsyncModalBuilder()
            .perform(confirmAction)
            .withTitle(
                AppText.getInstance().get("student.calendar.actions.saving"))
            .then(_refreshCalendarAndNavigateBack)
            .build()
            .run(context);
      } else {
        Navigator.pop(context);
      }
    }
  }

  Future<dynamic> _saveEvent(BuildContext context) async {
    await this._studentEventService.createEvent(this._studentEvent);
  }

  Future<dynamic> _updateEvent(BuildContext context) async {
    await this._studentEventService.updateEvent(this._studentEvent);
  }

  void _refreshCalendarAndNavigateBack(BuildContext context) {
    widget._onConfirm();
    Navigator.pop(context);
  }


}
