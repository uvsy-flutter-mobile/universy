import 'package:flutter/material.dart';
import 'package:universy/model/institution/schedule.dart';
import 'package:universy/text/formaters/schedule.dart';
import 'package:universy/text/text.dart';
import 'package:universy/text/translators/day.dart';
import 'package:universy/widgets/paddings/edge.dart';

class ScheduleInformationWidget extends StatelessWidget {
  final List<Schedule> _schedules;

  ScheduleInformationWidget({Key key, @required List<Schedule> schedules})
      : this._schedules = schedules,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SymmetricEdgePaddingWidget.horizontal(
      paddingValue: 20,
      child: _buildScheduleList(),
    );
  }

  Widget _buildScheduleList() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (context, position) {
        return _buildScheduleDetail(_schedules[position]);
      },
      itemCount: _schedules.length,
    );
  }

  Widget _buildScheduleDetail(Schedule schedule) {
    return SymmetricEdgePaddingWidget.vertical(
        paddingValue: 15,
        child: Column(
          children: <Widget>[
            _buildScheduleTimeInformation(schedule),
            _buildClassroomText(schedule),
          ],
        ));
  }

  Widget _buildScheduleTimeInformation(Schedule schedule) {
    return Row(
      children: [
        Expanded(
          child: _buildScheduleDayOfWeekText(schedule),
          flex: 5,
        ),
        Expanded(
          child: _buildScheduleTimeRange(schedule),
          flex: 5,
        )
      ],
    );
  }

  Widget _buildScheduleDayOfWeekText(Schedule schedule) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Icon(Icons.calendar_today),
        _buildSpaceBetweenIcons(),
        Text(
          DayTextTranslator().translate(schedule.dayOfWeek),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildScheduleTimeRange(Schedule schedule) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Icon(Icons.access_time),
        _buildSpaceBetweenIcons(),
        Text(
          ScheduleTimeRangeFormatter(schedule).format(),
          style: TextStyle(fontSize: 18),
        )
      ],
    );
  }

  SizedBox _buildSpaceBetweenIcons() => SizedBox(width: 5);

  Widget _buildClassroomText(Schedule schedule) {
    return OnlyEdgePaddedWidget.top(
      padding: 5,
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          _getClassroomText(schedule),
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }

  String _getClassroomText(Schedule schedule) {
    String classRoom = AppText.getInstance()
        .get("institution.dashboard.course.labels.classroom");
    return "$classRoom: ${schedule.classroom}";
  }
}
