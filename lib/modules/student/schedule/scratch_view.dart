import 'package:calendar_views/calendar_views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timetable_view/flutter_timetable_view.dart';
import 'package:universy/model/student/schedule.dart';
import 'package:universy/modules/student/schedule/bloc/cubit.dart';
import 'package:universy/modules/student/schedule/widgets/scratch_buttons.dart';
import 'package:universy/util/object.dart';

class ScratchView extends StatefulWidget {
  final StudentScheduleScratch _scratch;
  final bool _create;

  const ScratchView(
      {Key key,
      @required StudentScheduleScratch scratch,
      @required bool create})
      : this._scratch = scratch,
        this._create = create,
        super(key: key);

  @override
  _ScratchViewState createState() => _ScratchViewState();
}

class _ScratchViewState extends State<ScratchView> {
  StudentScheduleScratch _scratch;
  ScheduleCubit _cubit;
  bool _create;

  @override
  void didChangeDependencies() {
    if (isNull(_cubit)) {
      this._cubit = BlocProvider.of<ScheduleCubit>(context);
    }
    super.didChangeDependencies();
  }

  @override
  void initState() {
    this._scratch = widget._scratch;
    this._create = widget._create;
    super.initState();
  }

  @override
  void dispose() {
    this._scratch = null;
    this._create = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(child: _buildScratchHeader(context), flex: 2),
          Expanded(child: _buildScratchSchedule(), flex: 10)
        ],
      ),
      floatingActionButton:
          _create ? ScheduleActionButton.create() : ScheduleActionButton.edit(),
    );
  }

  Widget _buildScratchSchedule() {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    return _buildTimeTable();
  }

  Widget _buildTimeTable2() {
    return DayViewEssentials(
      properties: new DayViewProperties(
        days: <DateTime>[
          new DateTime.now(),
          DateTime.now().toUtc().add(new Duration(days: 1)).toLocal(),
        ],
      ),
    );
  }

  Widget _buildTimeTable() {
    return TimetableView(
      timetableStyle: TimetableStyle(
          cornerColor: Colors.amber,
          timelineColor: Colors.amber,
          timeItemTextColor: Colors.black,
          startHour: 7,
          endHour: 25,
          laneWidth: 70.0,
          timelineItemColor: Colors.amber,
          timelineBorderColor: Colors.grey),
      laneEventsList: [
        LaneEvents(
            lane: Lane(
                name: "Lunes",
                width: 70.0,
                textStyle: TextStyle(color: Colors.black)),
            events: [
              TableEvent(
                title: "1k2 - MAD",
                decoration: BoxDecoration(color: Colors.deepPurple),
                start: TableEventTime(hour: 8, minute: 0),
                end: TableEventTime(hour: 11, minute: 20),
              )
            ]),
        LaneEvents(
            lane: Lane(
                name: "Martes",
                width: 70.0,
                textStyle: TextStyle(color: Colors.black)),
            events: [
              TableEvent(
                title: "1k2 - SOR",
                decoration: BoxDecoration(color: Colors.amber),
                start: TableEventTime(hour: 12, minute: 0),
                end: TableEventTime(hour: 13, minute: 20),
              )
            ]),
        LaneEvents(
            lane: Lane(
                name: "Miercoles",
                width: 80.0,
                textStyle: TextStyle(color: Colors.black)),
            events: [
              TableEvent(
                title: "1k2 - SOR",
                decoration: BoxDecoration(color: Colors.amber),
                start: TableEventTime(hour: 08, minute: 30),
                end: TableEventTime(hour: 13, minute: 20),
              ),
              TableEvent(
                title: "1k2 - PAV",
                decoration: BoxDecoration(color: Colors.deepPurple),
                start: TableEventTime(hour: 08, minute: 45),
                end: TableEventTime(hour: 13, minute: 50),
              )
            ]),
        LaneEvents(
            lane: Lane(
                name: "Jueves",
                width: 60.0,
                textStyle: TextStyle(color: Colors.black)),
            events: [
              TableEvent(
                title: "1k2 - SOR",
                decoration: BoxDecoration(color: Colors.amber),
                start: TableEventTime(hour: 12, minute: 0),
                end: TableEventTime(hour: 13, minute: 20),
              )
            ]),
        LaneEvents(
            lane: Lane(
                name: "Viernes",
                width: 60.0,
                textStyle: TextStyle(color: Colors.black)),
            events: [
              TableEvent(
                title: "2k2 - AMII",
                decoration: BoxDecoration(color: Colors.lightBlue),
                start: TableEventTime(hour: 12, minute: 0),
                end: TableEventTime(hour: 13, minute: 20),
              )
            ]),
        LaneEvents(
            lane: Lane(
                name: "Sabado",
                width: 60.0,
                textStyle: TextStyle(color: Colors.black)),
            events: [
              TableEvent(
                title: "2k2 - AMII",
                decoration: BoxDecoration(color: Colors.lightBlue),
                start: TableEventTime(hour: 23, minute: 0),
                end: TableEventTime(hour: 23, minute: 50),
              )
            ]),
      ],
    );
  }

  Widget _buildScratchHeader(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildHeaderTitles(),
        SizedBox(width: 15),
        _buildEditButton(),
      ],
    );
  }

  Widget _buildEditButton() {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () => {},
      color: Colors.amber,
    );
  }

  Widget _buildHeaderTitles() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 15),
        _buildPeriodTitle(context),
        SizedBox(height: 5),
        _buildPeriodSubtitle(context)
      ],
    );
  }

  Widget _buildPeriodTitle(BuildContext context) {
    return Text("Primer cuatrimestre",
        style: Theme.of(context).primaryTextTheme.headline3); //TODO: text
  }

  Widget _buildPeriodSubtitle(BuildContext context) {
    return Text("Enero 2020 - Diciembre 2020",
        style: Theme.of(context).primaryTextTheme.bodyText1); //TODO: text
  }
}
