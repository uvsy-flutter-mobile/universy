import 'package:card_settings/card_settings.dart';
import 'package:card_settings/widgets/picker_fields/card_settings_list_picker.dart';
import 'package:card_settings/widgets/text_fields/card_settings_paragraph.dart';
import 'package:flutter/material.dart';
import 'package:optional/optional.dart';
import 'package:universy/model/student/event.dart';
import 'package:universy/modules/student/calendar/form/calendar-actions.dart';
import 'package:universy/modules/student/calendar/form/date-widget.dart';
import 'package:universy/modules/student/calendar/form/time-widget.dart';
import 'package:universy/modules/student/calendar/form/title-widget.dart';
import 'package:universy/text/text.dart';
import 'package:universy/text/translators/event_type.dart';
import 'package:universy/util/time-of-day.dart';

class StudentEventFormWidget extends StatefulWidget {
  final StudentEvent _studentEvent;
  final DateTime _daySelected;
  final Function() _onSaved;

  StudentEventFormWidget({
    Key key,
    StudentEvent studentEvent,
    DateTime daySelected,
    @required Function() onSaved,
  })  : this._daySelected = daySelected,
        this._studentEvent = studentEvent,
        this._onSaved = onSaved,
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

//  SaveLock<StudentEvent> _saveLock;

  void initState() {
    this._daySelected = widget._daySelected;
    this._formKey = GlobalKey<FormState>();
    this._studentEvent =
        Optional.ofNullable(widget._studentEvent).orElse(StudentEvent.empty());
    this._timeFrom =
        Optional.ofNullable(_studentEvent.timeFrom).orElse(TimeOfDay.now());
    this._timeTo =
        Optional.ofNullable(_studentEvent.timeTo).orElse(TimeOfDay.now());
//    this._saveLock = SaveLock.lock(snapshot: widget._studentEvent);
    super.initState();
  }

  void dispose() {
    this._daySelected = null;
    this._formKey = null;
    this._studentEvent = null;
    this._timeFrom = null;
    this._timeTo = null;
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
        child: CardSettings(
          children: <CardSettingsSection>[
            CardSettingsSection(
              children: <CardSettingsWidget>[
                _buildTitle(),
                _buildDate(),
                _buildTimeFrom(),
                _buildTimeTo(),
                _buildEventTypePicker(),
                _buildDescriptionText(),
                _buildActionButtons()
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return StudentEventTitleWidget(
      initialValue: _studentEvent.title ?? "",
      onSaved: _titleOnSave,
    );
  }

  void _titleOnSave(String title) {
    this._studentEvent.title = title;
  }

  Widget _buildDate() {
    DateTime eventDate = Optional.ofNullable(_studentEvent)
        .map(
          (event) => event.date,
        )
        .orElse(_daySelected);

    return StudentEventDateWidget(
      initialDate: eventDate,
      onSave: _dateOnSave,
    );
  }

  void _dateOnSave(DateTime selectedDate) {
    this._studentEvent.date = selectedDate;
  }

  Widget _buildTimeFrom() {
    return StudentEventTimeWidget(
      label: AppText.getInstance().get("student.calendar.form.timeFrom"),
      initialTime: _timeFrom,
      onChange: _updateTimeFrom,
      onSave: _timeFromOnSave,
    );
  }

  void _updateTimeFrom(selectedTime) {
    if (TimeOfDayComparator().isAfter(selectedTime, _timeTo)) {
      setState(() {
        this._timeFrom = selectedTime;
        this._timeTo = selectedTime;
      });
    } else {
      setState(() {
        this._timeFrom = selectedTime;
      });
    }
  }

  void _timeFromOnSave(TimeOfDay selectedTime) {
    _studentEvent.timeFrom = selectedTime;
  }

  Widget _buildTimeTo() {
    return StudentEventTimeWidget(
      label: AppText.getInstance().get("student.calendar.form.timeTo"),
      initialTime: _timeTo,
      onChange: _updateTimeTo,
      onSave: _timeToOnSave,
    );
  }

  void _updateTimeTo(selectedTime) {
    if (TimeOfDayComparator().isBefore(selectedTime, _timeFrom)) {
      setState(() {
        _timeTo = selectedTime;
        _timeFrom = selectedTime;
      });
    } else {
      setState(() {
        _timeTo = selectedTime;
      });
    }
  }

  void _timeToOnSave(TimeOfDay selectedTime) {
    _studentEvent.timeTo = selectedTime;
  }

  Widget _buildEventTypePicker() {
    Map<String, String> eventTypeMap = Map.fromIterable(
      EventTypeDescription.getEventTypes(),
      key: (event) => event.description,
      value: (event) => event.eventType,
    );

    String descriptionValue = Optional.ofNullable(_studentEvent)
        .map((event) => event.eventType)
        .map(EventTypeTranslator().translate)
        .orElse(eventTypeMap.keys.first);

    return CardSettingsListPicker(
      contentAlign: TextAlign.right,
      label: AppText.getInstance().get("student.calendar.form.typeEvent"),
      visible: true,
      initialValue: descriptionValue,
      options: eventTypeMap.keys.toList(),
      onSaved: (description) =>
          _studentEvent.eventType = eventTypeMap[description],
      onChanged: (description) {
        setState(() {
          descriptionValue = description;
          _studentEvent.eventType = eventTypeMap[description];
        });
      },
    );
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
      pressSaveEventButton: _pressSaveEventButton,
    );
  }

  void _pressSaveEventButton() async {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();

//      if (_saveLock.shouldSave(_studentEvent)) {
//        await AsyncModalBuilder()
//            .perform(_saveEvent)
//            .withTitle(AppText.getInstance().get("studentEvents.actions.saving"))
//            .then(_refreshCalendarAndNavigateBack)
//            .build()
//            .run(context);
//      } else {
//        Navigator.pop(context);
//      }
    }
  }

//  Future<void> _saveEvent(BuildContext context) async {
//    var sessionFactory = Provider.of<ServiceFactory>(context, listen: false);
//    var studentCareerService = sessionFactory.studentCareerService();
//    await studentCareerService.saveStudentEvent(this._studentEvent);
//  }

//  void _refreshCalendarAndNavigateBack(BuildContext context) {
//    widget._onSaved();
//    Navigator.pop(context);
//    _buildFlashBarOk();
//  }

//  void _buildFlashBarOk() {
////    FlushBarBuilder()
////        .withDuration(5)
////        .withIcon(Icon(Icons.spellcheck, color: Colors.green))
////        .withMessage(AppText.getInstance().get("studentEvents.actions.save"))
////        .show(context);
//  }

}
