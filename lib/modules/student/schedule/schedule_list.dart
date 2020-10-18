import 'package:flutter/material.dart';
import 'package:universy/model/student/schedule.dart';
import 'package:universy/modules/student/schedule/card.dart';

var mockedScheduleScratchList = [
  StudentScheduleScratch('scheduleScratchId', 'name,', 1602980186767,
      1602980186767, [], DateTime.now(), DateTime.now()),
  StudentScheduleScratch('scheduleScratchId', 'name,', 1602980186767,
      1602980186767, [], DateTime.now(), DateTime.now()),
];

class StudentScheduleListWidget extends StatelessWidget {
  /*List<StudentScheduleScratch> _scheduleScratches;

  const DisplayScratchesWidget(
      {Key key,
        @required List<StudentScheduleScratch> scheduleScratches})
      : this._scheduleScratches = scheduleScratches,
        super(key: key); */

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 600),
      child: ListView(
        children: <Widget>[
          ScheduleCard(
            studentScheduleScratch: mockedScheduleScratchList[0],
            onDelete: _handleOnDeleteSchedule,
            onTap: _handleOnTapSchedule,
          ),
          ScheduleCard(
            studentScheduleScratch: mockedScheduleScratchList[1],
            onDelete: _handleOnDeleteSchedule,
            onTap: _handleOnTapSchedule,
          ),
        ],
      ),
    );
  }

  void _handleOnDeleteSchedule(StudentScheduleScratch studentScheduleScratch) {
    print('handleOnDeleteSchedule $studentScheduleScratch');
  }

  void _handleOnTapSchedule(StudentScheduleScratch studentScheduleScratch) {
    print('handleOnTapSchedule $studentScheduleScratch');
  }
}
