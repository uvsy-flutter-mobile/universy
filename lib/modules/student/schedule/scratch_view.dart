import 'package:calendar_views/calendar_views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timetable_view/flutter_timetable_view.dart';
import 'package:universy/model/student/schedule.dart';
import 'package:universy/modules/student/schedule/bloc/cubit.dart';
import 'package:universy/modules/student/schedule/widgets/scratch_buttons.dart';
import 'package:universy/modules/student/schedule/widgets/scratch_form.dart';
import 'package:universy/text/text.dart';
import 'package:universy/util/object.dart';
import 'package:universy/widgets/buttons/uvsy/cancel.dart';
import 'package:universy/widgets/buttons/uvsy/save.dart';
import 'package:universy/widgets/dialog/title.dart';

class ScratchView extends StatefulWidget {
  final StudentScheduleScratch _scratch;
  final bool _create;

  const ScratchView(
      {Key key, StudentScheduleScratch scratch, @required bool create})
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
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _buildScratchHeader(context),
          Expanded(child: _buildScratchSchedule()),
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
          mainBackgroundColor: Colors.white,
          startHour: 7,
          endHour: 25,
          laneWidth: 70.0,
          laneHeight: 45,
          timeItemWidth: 45,
          timelineItemColor: Colors.white,
          timelineBorderColor: Colors.grey[300]),
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
                width: 70.0,
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
                name: "Viernes",
                width: 70.0,
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
                width: 70.0,
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
    return Container(
      color: Colors.grey[100],
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildHeaderTitles(),
          _buildEditButton(context),
        ],
      ),
    );
  }

  Widget _buildEditButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () => _editScratchTitle(context),
      color: Colors.amber,
    );
  }

  void _editScratchTitle(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => TitleDialog(
        title: AppText.getInstance()
            .get("student.schedule.createScratchDialog.alertTitle"),
        content: ScratchForm(),
        actions: <Widget>[
          SaveButton(),
          CancelButton(onCancel: () => Navigator.of(context).pop())
        ],
      ),
    );
  }

  Widget _buildHeaderTitles() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
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
