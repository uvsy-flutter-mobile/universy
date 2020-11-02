import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timetable_view/flutter_timetable_view.dart';
import 'package:universy/model/institution/schedule.dart';
import 'package:universy/model/institution/subject.dart';
import 'package:universy/model/student/schedule.dart';
import 'package:universy/modules/student/schedule/bloc/cubit.dart';
import 'package:universy/modules/student/schedule/dialogs/scratch_form.dart';
import 'package:universy/modules/student/schedule/widgets/scratch_buttons.dart';
import 'package:universy/text/text.dart';
import 'package:universy/text/translators/day.dart';
import 'package:universy/util/object.dart';
import 'package:universy/util/strings.dart';
import 'package:universy/widgets/formfield/text/validators.dart';

class ScratchView extends StatefulWidget {
  final StudentScheduleScratch _scratch;
  final bool _create;
  final ScheduleCubit _cubit;
  final List<ScheduleScratchCourse> _scratchCourses;
  final List<int> _levels;
  final List<InstitutionSubject> _subjects;

  const ScratchView(
      {Key key,
      StudentScheduleScratch scratch,
      @required bool create,
      @required List<ScheduleScratchCourse> scratchCourses,
      @required List<int> levels,
      @required List<InstitutionSubject> subjects,
      ScheduleCubit cubit})
      : this._scratch = scratch,
        this._create = create,
        this._cubit = cubit,
        this._scratchCourses = scratchCourses,
        this._levels = levels,
        this._subjects = subjects,
        super(key: key);

  @override
  _ScratchViewState createState() => _ScratchViewState();
}

class _ScratchViewState extends State<ScratchView> {
  StudentScheduleScratch _scratch;
  ScheduleCubit _cubit;
  bool _create;
  TextEditingController _nameTextController;
  List<ScheduleScratchCourse> _scratchCourses;
  List<int> _levels;
  List<InstitutionSubject> _subjects;

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
    this._cubit = widget._cubit;
    this._scratchCourses = widget._scratchCourses;
    this._levels = widget._levels;
    this._subjects = widget._subjects;
    this._nameTextController =
        TextEditingController(text: widget._scratch.name);
    super.initState();
  }

  @override
  void dispose() {
    this._scratch = null;
    this._cubit = null;
    this._create = null;
    this._nameTextController.dispose();
    this._nameTextController = null;
    this._scratchCourses = null;
    this._levels = null;
    this._subjects = null;
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
          Expanded(child: _buildScheduleCalendar()),
        ],
      ),
      floatingActionButton: _create
          ? ScheduleActionButton.create(
              onNewCourse: _addNewScratchCourse,
              levels: _levels,
              subjects: _subjects,
              scratchCourses: _scratchCourses,
            )
          : ScheduleActionButton.edit(
              onNewCourse: _addNewScratchCourse,
              onUpdatedCourses: _updateScratchCourses,
              scratchCourseList: _scratch.selectedCourses,
              levels: _levels,
              subjects: _subjects,
              scratchCourses: _scratchCourses,
            ), //TODO: validar el form y guardarlo
    );
  }

  void _addNewScratchCourse(ScheduleScratchCourse newScratchCourse) {
    setState(() {
      _scratch.selectedCourses.add(newScratchCourse);
    });
  }

  void _updateScratchCourses(
      List<ScheduleScratchCourse> updatedSelectedCourses) {
    setState(() {
      _scratch.selectedCourses = [...updatedSelectedCourses];
    });
  }

  Widget _buildScheduleCalendar() {
    List<LaneEvents> emptyLane = [];
    return TimetableView(
      timetableStyle: TimetableStyle(
          cornerColor: Colors.amber,
          timelineColor: Colors.amber,
          timeItemTextColor: Colors.black,
          mainBackgroundColor: Colors.white,
          startHour: 8,
          endHour: 25,
          laneWidth: 70.0,
          laneHeight: 45,
          timeItemWidth: 45,
          timelineItemColor: Colors.white,
          timelineBorderColor: Colors.grey[300]),
      laneEventsList: _buildSchedulerList(),
    );
  }

  List<LaneEvents> _buildSchedulerList() {
    List<Lane> lanes = _buildLanes();
    List<LaneEvents> lanesEvents = [];
    lanes.forEach((element) {
      lanesEvents.add(_buildLaneEvent(element, []));
    });

    if (_scratch.selectedCourses.isNotEmpty ||
        notNull(_scratch.selectedCourses)) {
      lanesEvents = _buildExistingCourses(lanesEvents);
    }

    return lanesEvents;
  }

  List<LaneEvents> _buildExistingCourses(List<LaneEvents> lanesEvents) {
    DayTextTranslator dayTextTranslator = new DayTextTranslator();
    List<ScheduleScratchCourse> courses = _scratch.selectedCourses;
    courses.forEach((e) {
      e.period.scheduleList.forEach((schedule) {
        TableEventTime beginTime = _buildEventTime(schedule.beginTime);
        TableEventTime endTime = _buildEventTime(schedule.endTime);
        TableEvent calendarCourse =
            _buildEvent(e.subjectName, e.commission.name, beginTime, endTime);
        int index = lanesEvents.indexWhere((laneEvent) => stringEquals(
            laneEvent.lane.name,
            dayTextTranslator.translate(schedule.dayOfWeek)));
        lanesEvents[index].events.add(calendarCourse);
      });
    });
    return lanesEvents;
  }

  LaneEvents _buildLaneEvent(Lane lane, List<TableEvent> events) {
    return LaneEvents(lane: lane, events: events);
  }

  TableEventTime _buildEventTime(int time) {
    int hours = (time ~/ 100);
    int minutes = (time % 100);
    return TableEventTime(hour: hours, minute: minutes);
  }

  Lane _buildLane(String dayOfWeek) {
    return Lane(
        name: dayOfWeek,
        width: 70.0,
        textStyle: TextStyle(color: Colors.black));
  }

  List<Lane> _buildLanes() {
    List<String> list = [
      "Lunes",
      "Martes",
      "Miércoles",
      "Jueves",
      "Viernes",
      "Sábado"
    ];
    List<Lane> lanes = list.map((e) => _buildLane(e)).toList();
    return lanes;
  }

  TableEvent _buildEvent(String subjectName, String commissionName,
      TableEventTime start, TableEventTime end) {
    String title = "$subjectName - $commissionName";
    return TableEvent(
      title: title,
      decoration: BoxDecoration(color: Colors.lightBlue),
      start: start,
      end: end,
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
            Expanded(child: _buildHeaderTitles(), flex: 3),
            _buildEditButton(context),
          ],
        ));
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
        builder: (dialogContext) => ScratchFormDialog(
              studentScheduleScratch: this._scratch,
              create: false,
              onSave: _updateScratch,
            ));
  }

  void _updateScratch(StudentScheduleScratch scratchUpdated) {
    setState(() {
      this._scratch = scratchUpdated;
    });
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
    return Text(_scratch.name,
        overflow: TextOverflow.clip,
        style: Theme.of(context).primaryTextTheme.headline3);
  }

  Widget _buildPeriodSubtitle(BuildContext context) {
    String begin = _scratch.beginDate.toString();
    String end = _scratch.endDate.toString();
    return Text("$begin - $end",
        style: Theme.of(context).primaryTextTheme.bodyText1);
  }
}
