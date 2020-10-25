import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:logger/logger.dart';
import 'package:universy/model/institution/course.dart';
import 'package:universy/model/student/schedule.dart';
import 'package:universy/model/subject.dart';

const double SEPARATOR_SPACE = 15;

class SelectCourseWidget extends StatefulWidget {
  List<Level> _levels;
  List<Subject> _subjects;
  List<Course> _courses;
  Function(ScheduleScratchCourse) _onSelectedScratchCourse;

  SelectCourseWidget({
    @required List<Level> levels,
    @required List<Subject> subjects,
    @required List<Course> courses,
    @required Function(ScheduleScratchCourse) onSelectedScratchCourse,
  })  : this._levels = levels,
        this._subjects = subjects,
        this._courses = courses,
        this._onSelectedScratchCourse = onSelectedScratchCourse,
        super();

  @override
  State<SelectCourseWidget> createState() {
    return SelectCourseWidgetState(this._levels, this._subjects, this._courses,
        this._onSelectedScratchCourse);
  }
}

class SelectCourseWidgetState extends State<SelectCourseWidget> {
  List<Level> _levels;
  List<Subject> _subjects;
  List<Course> _courses;
  List<ScheduleScratchCourse> _scratchCourses;
  ScheduleScratchCourse _selectedScratchCourse;
  Function(ScheduleScratchCourse) _onSelectedScratchCourse;

  SelectCourseWidgetState(this._levels, this._subjects, this._courses,
      this._onSelectedScratchCourse);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
