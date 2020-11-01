import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:universy/business/schedule_scratch/course_list_generator.dart';
import 'package:universy/model/institution/commission.dart';
import 'package:universy/model/institution/course.dart';
import 'package:universy/model/institution/professor.dart';
import 'package:universy/model/institution/schedule.dart';
import 'package:universy/model/institution/subject.dart';
import 'package:universy/model/student/schedule.dart';
import 'package:universy/modules/student/schedule/widgets/scratch_course_card.dart';
import 'package:universy/text/formaters/couring_period.dart';
import 'package:universy/text/formaters/professor.dart';
import 'package:universy/text/formaters/schedule.dart';
import 'package:universy/text/text.dart';
import 'package:universy/util/object.dart';
import 'package:universy/widgets/cards/rectangular.dart';
import 'package:universy/widgets/paddings/edge.dart';

class CourseInfoCardWidget extends StatelessWidget {
  final ScheduleScratchCourse _scratchCourse;
  final Function(ScheduleScratchCourse) _onTap;
  final bool _isSelected;

  const CourseInfoCardWidget(
      {@required scratchCourse,
      Function(ScheduleScratchCourse) onTap,
      bool isSelected})
      : this._scratchCourse = scratchCourse,
        this._onTap = onTap,
        this._isSelected = isSelected,
        super();

  @override
  Widget build(BuildContext context) {
    return CircularRoundedRectangleCard(
        radius: 12,
        elevation: 2,
        color: _isSelected ? Theme.of(context).primaryColor : Colors.white,
        child: InkWell(
          onTap: () => _onTap(_scratchCourse),
          child: Container(
            padding: EdgeInsets.all(15),
            child: CourseInfoWidget(scratchCourse: _scratchCourse),
          ),
        ));
  }
}

class CourseInfoWidget extends StatelessWidget {
  final ScheduleScratchCourse _scratchCourse;

  const CourseInfoWidget({@required ScheduleScratchCourse scratchCourse})
      : this._scratchCourse = scratchCourse,
        super();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: _buildCommissionName(context),
          flex: 20,
        ),
        Expanded(
          child: _buildProfessorList(context),
          flex: 45,
        ),
        Expanded(
          child: _buildScheduleList(context),
          flex: 35,
        ),
      ],
    );
  }

  Widget _buildCommissionName(BuildContext context) {
    return Text(
      _scratchCourse.commission.name,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headline5,
    );
  }

  Widget _buildScheduleList(BuildContext context) {
    List<Schedule> scheduleList = _scratchCourse.period.scheduleList;
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, position) {
        Schedule scheduleItem = scheduleList[position];
        String timeRange = ScheduleTimeRangeFormatter(scheduleItem).format();
        return SymmetricEdgePaddingWidget.vertical(
          paddingValue: 2,
          child: Column(children: [
            Text(scheduleItem.dayOfWeek,
                style: Theme.of(context).textTheme.subtitle1),
            Text(timeRange, style: Theme.of(context).textTheme.caption)
          ]),
        );
      },
      itemCount: scheduleList.length,
    );
  }

  Widget _buildProfessorList(BuildContext context) {
    List<Professor> professorsList = _scratchCourse.period.professors;
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, position) {
        Professor professorItem = professorsList[position];
        String nameFormatted = ProfessorNameFormatter(professorItem).format();
        return SymmetricEdgePaddingWidget.vertical(
            paddingValue: 3,
            child: Text(nameFormatted,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption));
      },
      itemCount: professorsList.length,
    );
  }
}
