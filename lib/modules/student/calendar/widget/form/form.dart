import 'package:flutter/material.dart';
import 'package:optional/optional.dart';
import 'package:provider/provider.dart';
import 'package:universy/constants/event_types.dart';
import 'package:universy/model/lock.dart';
import 'package:universy/model/student/event.dart';
import 'package:universy/modules/student/calendar/widget/form/calendar_actions.dart';
import 'package:universy/modules/student/calendar/widget/form/description.dart';
import 'package:universy/modules/student/calendar/widget/form/event_type.dart';
import 'package:universy/modules/student/calendar/widget/form/title.dart';
import 'package:universy/services/factory.dart';
import 'package:universy/services/manifest.dart';
import 'package:universy/text/text.dart';
import 'package:universy/util/time_of_day.dart';
import 'package:universy/widgets/async/modal.dart';
import 'package:universy/widgets/buttons/uvsy/cancel.dart';
import 'package:universy/widgets/dialog/confirm.dart';
import 'package:universy/widgets/formfield/picker/date.dart';
import 'package:universy/widgets/formfield/picker/time.dart';

const EMPTY_STRING = "";

class StudentEventFormWidget extends StatefulWidget {
  final StudentEvent _studentEvent;
  final DateTime _daySelected;
  final Function() _onConfirm;
  final bool _create;

  StudentEventFormWidget({
    Key key,
    StudentEvent studentEvent,
    DateTime daySelected,
    bool create,
    @required Function() onConfirm,
  })  : this._daySelected = daySelected,
        this._studentEvent = studentEvent,
        this._onConfirm = onConfirm,
        this._create = create,
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
  bool _create;

  StateLock<StudentEvent> _stateLock;

  void initState() {
    this._daySelected = widget._daySelected;
    this._formKey = GlobalKey<FormState>();
    this._create = widget._create;
    this._studentEvent =
        Optional.ofNullable(widget._studentEvent).orElse(StudentEvent.empty());
    this._timeFrom =
        Optional.ofNullable(_studentEvent.timeFrom).orElse(TimeOfDay.now());
    this._timeTo =
        Optional.ofNullable(_studentEvent.timeTo).orElse(TimeOfDay.now());
    this._stateLock = StateLock.lock(snapshot: widget._studentEvent);
    this._titleTextEditingController = TextEditingController(
        text: _create ? EMPTY_STRING : _studentEvent.title);
    this._descriptionTextEditingController = TextEditingController(
        text: _create ? EMPTY_STRING : _studentEvent.description);
    this._studentEvent.eventType =
        _create ? EventType.FINAL_EXAM.toString() : _studentEvent.eventType;
    this._studentEvent.timeFrom =
        _create ? TimeOfDay.now() : _studentEvent.timeFrom;
    this._studentEvent.timeTo =
        _create ? TimeOfDay.now() : _studentEvent.timeTo;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    var sessionFactory = Provider.of<ServiceFactory>(context, listen: false);
    this._studentEventService = sessionFactory.studentEventService();
    super.didChangeDependencies();
  }

  void dispose() {
    this._create = null;
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
    var appBarText = _create
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
                _buildDate(context),
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
    this._titleTextEditingController.addListener(_updateTitle);
    return SizedBox(
        width: 200,
        child: StudentEventTitleWidget(
          textEditingController: this._titleTextEditingController,
        ));
  }

  Widget _buildDate(BuildContext context) {
    DateTime eventDate = Optional.ofNullable(_studentEvent)
        .map(
          (event) => event.date,
        )
        .orElse(_daySelected);
    String label = AppText.getInstance().get("student.calendar.form.eventDate");

    return SizedBox(
        width: 200,
        child: StudentEventDateWidget(
          initialValue: eventDate,
          context: context,
          label: label,
          onSaved: _updateDate,
        ));
  }

  Widget _buildTimeRange(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width / 1.8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 4.3,
              child: _buildTimeFrom(context),
            ),
            SizedBox(
              width: 10,
              child: Text(
                '-',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 26),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 4.3,
              child: _buildTimeTo(context),
            ),
          ],
        ));
  }

  Widget _buildTimeFrom(BuildContext context) {
    String label = AppText.getInstance().get("student.calendar.form.timeFrom");

    return StudentEventTimeWidget(
        label: label,
        initialValue: _timeFrom,
        context: context,
        onChanged: _updateTimeFrom);
  }

  Widget _buildTimeTo(BuildContext context) {
    String label = AppText.getInstance().get("student.calendar.form.timeTo");

    return StudentEventTimeWidget(
      context: context,
      label: label,
      initialValue: _timeTo,
      onChanged: _updateTimeTo,
    );
  }

  Widget _buildEventTypePicker() {
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
              onChange: _updateEventType,
              eventType: _studentEvent.eventType,
            ))
      ],
    );
  }

  Widget _buildDescriptionText() {
    _descriptionTextEditingController.addListener(_updateDescription);
    return StudentEventDescriptionWidget(
      textEditingController: _descriptionTextEditingController,
      label: AppText.getInstance().get("student.calendar.form.description"),
      descriptionLabel:
          AppText.getInstance().get("student.calendar.form.descriptionCheck"),
    );
  }

  Widget _buildActionButtons() {
    return StudentCalendarFormActionsWidget(
      context: context,
      pressSaveEventButton: _pressConfirmButton,
    );
  }

  void _updateEventType(String eventType) {
    _studentEvent.eventType = eventType;
  }

  void _updateDescription() {
    this._studentEvent.description = _descriptionTextEditingController.text;
  }

  void _updateTimeTo(TimeOfDay selectedTime) {
    setState(() {
      this._timeTo = selectedTime;
      this._studentEvent.timeTo = _timeTo;
    });
  }

  void _updateTitle() {
    setState(() {
      this._studentEvent.title = this._titleTextEditingController.text;
    });
  }

  void _updateDate(DateTime selectedDate) {
    setState(() {
      this._studentEvent.date = selectedDate;
    });
  }

  void _updateTimeFrom(TimeOfDay selectedTime) {
    setState(() {
      this._timeFrom = selectedTime;
      this._studentEvent.timeFrom = _timeFrom;
    });
  }

  bool _validateDate() {
    if (TimeOfDayComparator().isAfter(_timeFrom, _timeTo)) {
      _buildTimeDialog(
          "Verificá las horas del evento. La hora de inicio es mayor a la de fin");
      return false;
    } else {
      return true;
    }
  }

  _buildTimeDialog(String message) {
    showDialog(
        context: context,
        builder: (context) => ConfirmDialog(
              title: "Algo anda mal",
              content: message,
              buttons: <Widget>[
                CancelButton(onCancel: () => Navigator.of(context).pop())
              ],
            ));
  }

  void _pressConfirmButton() async {
    final form = _formKey.currentState;
    if (form.validate()) {
      if (_validateDate()) {
        form.save();

        if (_stateLock.hasChange(_studentEvent)) {
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
