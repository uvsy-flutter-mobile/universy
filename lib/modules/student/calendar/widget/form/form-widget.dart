import 'package:card_settings/card_settings.dart';
import 'package:card_settings/widgets/text_fields/card_settings_paragraph.dart';
import 'package:flutter/material.dart';
import 'package:optional/optional.dart';
import 'package:provider/provider.dart';
import 'package:universy/model/student/event.dart';
import 'package:universy/modules/student/calendar/widget/form/calendar-actions.dart';
import 'package:universy/modules/student/calendar/widget/form/date-widget.dart';
import 'package:universy/modules/student/calendar/widget/form/event-type.dart';
import 'package:universy/modules/student/calendar/widget/form/keys.dart';
import 'package:universy/modules/student/calendar/widget/form/time-widget.dart';
import 'package:universy/modules/student/calendar/widget/form/title-widget.dart';
import 'package:universy/services/factory.dart';
import 'package:universy/services/manifest.dart';
import 'package:universy/text/text.dart';
import 'package:universy/util/save-lock.dart';
import 'package:universy/util/time-of-day.dart';
import 'package:universy/widgets/async/modal.dart';

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
        TextEditingController(text: _studentEvent.title ?? "");
    super.initState();
  }

  @override
  void didChangeDependencies() {
    var sessionFactory = Provider.of<ServiceFactory>(context, listen: false);
    this._studentEventService = sessionFactory.studentEventService();
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
      data: Theme.of(context).copyWith(
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.orange, fontSize: 20.0),
        ),
      ),
      child: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(15.0),
          children: <Widget>[
            Column(
              children: [
                _buildTitle(),
                _buildDate(),
                _buildTimeFrom(),
                _buildTimeTo(),
                _buildEventTypePicker(),
//                _buildDescriptionText(),
//                _buildActionButtons()
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    _titleTextEditingController.addListener(_titleOnSave);
    return StudentEventTitleWidget(
      textEditingController: _titleTextEditingController,
//      initialValue: _studentEvent.title ?? "",
    );
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

    return StudentEventDateWidget(
      key: CALENDAR_KEY_TIME_FROM,
      label: AppText.getInstance().get("student.calendar.form.timeFrom"),
      selectedDate: eventDate,
      onChange: _updateDate,
    );
  }

  void _dateOnSave(DateTime selectedDate) {
    this._studentEvent.date = selectedDate;
  }

  Widget _buildTimeFrom() {
    return StudentEventTimeWidget(
      key: CALENDAR_KEY_TIME_FROM,
      label: AppText.getInstance().get("student.calendar.form.timeFrom"),
      selectedTime: _timeFrom,
      onChange: _updateTimeFrom,
    );
  }

  void _updateTimeFrom(selectedTime) {
    var timeTo = TimeOfDayComparator().isAfter(selectedTime, _timeTo)
        ? selectedTime
        : this._timeTo;
    this._timeFrom = selectedTime;
    this._timeTo = timeTo;
  }

  void _updateTimeTo(selectedTime) {
    var timeFrom = TimeOfDayComparator().isBefore(selectedTime, _timeFrom)
        ? selectedTime
        : this._timeFrom;
    this._timeFrom = selectedTime;
    this._timeTo = timeFrom;
  }

  void _updateDate(selectedDate) {
    this._daySelected = selectedDate;
  }

  void _timeFromOnSave(TimeOfDay selectedTime) {
    _studentEvent.timeFrom = selectedTime;
  }

  Widget _buildTimeTo() {
    return StudentEventTimeWidget(
      key: CALENDAR_KEY_TIME_TO,
      label: AppText.getInstance().get("student.calendar.form.timeTo"),
      selectedTime: _timeTo,
      onChange: _updateTimeTo,
    );
  }

  void _timeToOnSave(TimeOfDay selectedTime) {
    _studentEvent.timeTo = selectedTime;
  }

  Widget _buildEventTypePicker() {
    return SizedBox(
        height: 185,
        child: StudentEventTypeWidget(
          onChange: _onEventTypeChange,
          eventType: _studentEvent.eventType,
        ));
  }

  void _onEventTypeChange(String eventType) {
    _studentEvent.eventType = eventType;
  }

  Widget _buildDescriptionText() {
    return CardSettingsParagraph(
      label: AppText.getInstance().get("student.calendar.form.description"),
      initialValue: _studentEvent.description,
      maxLengthEnforced: true,
      contentAlign: TextAlign.left,
      onSaved: (description) => _studentEvent.description = description,
      onChanged: (description) {
        setState(() {
          _studentEvent.description = description;
        });
      },
    );
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
//    _buildFlashBarOk();
  }

//  void _buildFlashBarOk() {
////    FlushBarBuilder()
////        .withDuration(5)
////        .withIcon(Icon(Icons.spellcheck, color: Colors.green))
////        .withMessage(AppText.getInstance().get("studentEvents.actions.save"))
////        .show(context);
//  }

}
