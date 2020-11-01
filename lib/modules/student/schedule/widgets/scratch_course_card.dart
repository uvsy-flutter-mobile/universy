import 'package:flutter/material.dart';
import 'package:universy/model/student/schedule.dart';
import 'package:universy/modules/student/schedule/widgets/course_info.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/cards/rectangular.dart';

class ScratchCourseCard extends StatelessWidget {
  final ScheduleScratchCourse _scheduleScratchCourse;
  final Function(ScheduleScratchCourse) _onRemove;

  const ScratchCourseCard(
      {@required ScheduleScratchCourse scheduleScratchCourse,
      @required Function(ScheduleScratchCourse) onRemove})
      : this._scheduleScratchCourse = scheduleScratchCourse,
        this._onRemove = onRemove,
        super();

  @override
  Widget build(BuildContext context) {
    return CircularRoundedRectangleCard(
        radius: 8,
        color: Colors.white,
        elevation: 4,
        child: Column(
          children: <Widget>[
            _buildCardHeader(context),
            Divider(),
            _buildCardContent()
          ],
        ));
  }

  Widget _buildCardHeader(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              _scheduleScratchCourse.subjectName,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            IconButton(
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              icon: Icon(Icons.clear),
              onPressed: () => _onRemove(_scheduleScratchCourse),
            )
          ],
        ));
  }

  Widget _buildCardContent() {
    return Container(
        child: CourseInfoWidget(
      scratchCourse: _scheduleScratchCourse,
    ));
  }
}
