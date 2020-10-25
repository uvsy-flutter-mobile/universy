import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:logger/logger.dart';
import 'package:universy/business/schedule_scratch/course_list_generator.dart';
import 'package:universy/model/institution/commission.dart';
import 'package:universy/model/institution/course.dart';
import 'package:universy/model/student/schedule.dart';
import 'package:universy/model/subject.dart';
import 'package:universy/util/object.dart';

const double SEPARATOR_SPACE = 15;

class SelectCourseWidget extends StatefulWidget {
  final List<Level> _levels;
  final List<Subject> _subjects;
  final List<Course> _courses;
  final List<Commission> _commissions;
  final Function(ScheduleScratchCourse) _onSelectedScratchCourse;

  SelectCourseWidget({
    @required List<Level> levels,
    @required List<Subject> subjects,
    @required List<Course> courses,
    @required List<Commission> commissions,
    @required Function(ScheduleScratchCourse) onSelectedScratchCourse,
  })  : this._levels = levels,
        this._subjects = subjects,
        this._courses = courses,
        this._commissions = commissions,
        this._onSelectedScratchCourse = onSelectedScratchCourse,
        super();

  @override
  State<SelectCourseWidget> createState() {
    return SelectCourseWidgetState(this._levels, this._subjects, this._courses,
        this._commissions, this._onSelectedScratchCourse);
  }
}

class SelectCourseWidgetState extends State<SelectCourseWidget> {
  List<Level> _levels;
  List<Subject> _subjects;
  List<Course> _courses;
  List<Commission> _commissions;
  List<ScheduleScratchCourse> _scratchCourses;
  ScheduleScratchCourse _selectedScratchCourse;
  Function(ScheduleScratchCourse) _onSelectedScratchCourse;

  SelectCourseWidgetState(this._levels, this._subjects, this._courses,
      this._commissions, this._onSelectedScratchCourse);

  @override
  void initState() {
    _generateScratchCourses();
    super.initState();
  }

  void _generateScratchCourses() {
    _courses.forEach((Course course) {
      var generator =
          ScheduleScratchCourseListGenerator(_subjects, _commissions, course);
      var scratchCourseListFragment = generator.generate();
      if (notNull(scratchCourseListFragment)) {
        _scratchCourses.addAll(scratchCourseListFragment);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
