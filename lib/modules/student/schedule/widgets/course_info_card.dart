import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:universy/business/schedule_scratch/course_list_generator.dart';
import 'package:universy/model/institution/commission.dart';
import 'package:universy/model/institution/course.dart';
import 'package:universy/model/institution/subject.dart';
import 'package:universy/model/student/schedule.dart';
import 'package:universy/text/text.dart';
import 'package:universy/util/object.dart';
import 'package:universy/widgets/cards/rectangular.dart';

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
        radius: 8,
        elevation: 2,
        color: _isSelected ? Theme.of(context).primaryColor : Colors.white,
        child: InkWell(
          onTap: () => _onTap(_scratchCourse),
          child: Container(
            padding: EdgeInsets.all(25),
            child: Text(_scratchCourse.subjectId.toString()),
          ),
        ));
  }
}
