import "package:collection/collection.dart";
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:universy/model/student/event.dart';
import 'package:universy/modules/student/calendar/bloc/panel/cubit.dart';
import 'package:universy/modules/student/calendar/bloc/table-calendar/cubit.dart';
import 'package:universy/modules/student/calendar/widget/form/form.dart';
import 'package:universy/system/locale.dart';
import 'package:universy/widgets/paddings/edge.dart';

class StudentCalendarWidget extends StatefulWidget {
  final DateTime selectedDate;
  final List<StudentEvent> studentEvents;

  StudentCalendarWidget({Key key, this.selectedDate, this.studentEvents})
      : super(key: key);

  @override
  _StudentCalendarWidgetState createState() => _StudentCalendarWidgetState();
}

class _StudentCalendarWidgetState extends State<StudentCalendarWidget> {
  CalendarController _calendarController;

  @override
  void initState() {
    this._calendarController = CalendarController();
    super.initState();
  }

  @override
  void dispose() {
    this._calendarController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(StudentCalendarWidget oldWidget) {
    if (_hasDateChange(oldWidget) || _haveEventsChanged(oldWidget)) {
      Map<DateTime, List> dateEventMap =
          _getStudentEventsMap(widget.studentEvents);
      DateTime selectedDate = widget.selectedDate;

      this._dispatchSelectedDay(dateEventMap[selectedDate]);
    }
    super.didUpdateWidget(oldWidget);
  }

  bool _hasDateChange(StudentCalendarWidget oldWidget) {
    return oldWidget.selectedDate != widget.selectedDate;
  }

  bool _haveEventsChanged(StudentCalendarWidget oldWidget) {
    return !ListEquality()
        .equals(oldWidget.studentEvents, widget.studentEvents);
  }

  Map<DateTime, List> _getStudentEventsMap(List<StudentEvent> studentEvents) {
    return groupBy(studentEvents, (event) => event.date);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildTableCalendar(),
        _buildNewEventButton(),
      ],
    );
  }

  Widget _buildTableCalendar() {
    return TableCalendar(
      // TODO: This line was added because the lib is broken.
      events: _getStudentEventsMap(widget.studentEvents),
      locale: SystemLocale.getSystemLocale().toString(),
      calendarController: _calendarController,
      initialCalendarFormat: CalendarFormat.month,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.monday,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: const {
        CalendarFormat.month: '',
      },
      calendarStyle: _buildCalendarStyle(),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle:
            TextStyle().copyWith(color: Theme.of(context).accentColor),
      ),
      headerStyle: _buildHeaderStyle(),
      builders: CalendarBuilders(markersBuilder: _buildCalendarMarkers),
      initialSelectedDay: widget.selectedDate,
      onDaySelected: _onDaySelected,
      // TODO: This code is commented given that the lib of table calendar is broken.
      // onVisibleDaysChanged: _onVisibleDaysChanged,
    );
  }

  List<Widget> _buildCalendarMarkers(
      BuildContext context, DateTime date, List events, List h) {
    return events.isNotEmpty
        ? [
            Positioned(
                right: 1, bottom: 1, child: _buildEventsMarker(date, events))
          ]
        : [];
  }

  CalendarStyle _buildCalendarStyle() {
    return CalendarStyle(
      selectedColor: Theme.of(context).primaryColor,
      todayColor: Color(0xFFE8E8E8),
      todayStyle: TextStyle().copyWith(color: Colors.black),
      markersColor: Colors.orange,
      weekendStyle: TextStyle().copyWith(color: Theme.of(context).accentColor),
      outsideDaysVisible: false,
    );
  }

  HeaderStyle _buildHeaderStyle() {
    return HeaderStyle(
      centerHeaderTitle: true,
      formatButtonVisible: false,
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: _buildEventLengthBox(date),
      width: 16.0,
      height: 16.0,
      child: Center(child: _buildEventLength(events)),
    );
  }

  BoxDecoration _buildEventLengthBox(DateTime date) {
    return BoxDecoration(
      shape: BoxShape.rectangle,
      color: _calendarController.isSelected(date)
          ? Theme.of(context).accentColor
          : Theme.of(context).indicatorColor,
    );
  }

  Widget _buildEventLength(List events) {
    return Text(
      '${events.length}',
      style: TextStyle().copyWith(
        color: Colors.white,
        fontSize: 12.0,
      ),
    );
  }

  Widget _buildNewEventButton() {
    return Container(
      alignment: Alignment.topRight,
      child: SymmetricEdgePaddingWidget.horizontal(
        paddingValue: 20,
        child: FloatingActionButton(
          backgroundColor: Theme.of(context).buttonColor,
          child: Icon(Icons.add),
          onPressed: () => _navigateToNewEvent(),
        ),
      ),
    );
  }

  void _navigateToNewEvent() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => StudentEventFormWidget(
          create: true,
          onConfirm: _refreshCalendar,
          daySelected: _calendarController.selectedDay,
        ),
      ),
    );
  }

  void _onDaySelected(DateTime day, List events) {
    List<StudentEvent> eventsSelected = List<StudentEvent>.from(events);
    this._dispatchSelectedDay(eventsSelected);
  }

  void _dispatchSelectedDay(List eventsSelected) {
    List<StudentEvent> eventsToPanel =
        List<StudentEvent>.from(eventsSelected ?? []);
    EventPanelCubit eventsPanelCubit =
        BlocProvider.of<EventPanelCubit>(context);
    eventsPanelCubit.daySelectedChange(eventsToPanel);
  }

  void _refreshCalendar() {
    TableCalendarCubit tableCalendarCubit =
        BlocProvider.of<TableCalendarCubit>(context);
    tableCalendarCubit.refreshTableCalendar(_getSelectedDate());
  }

  DateTime _getSelectedDate() {
    DateTime selectedDate = _calendarController.selectedDay;
    return DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
  }
}
