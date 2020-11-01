import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:universy/business/schedule_scratch/course_list_generator.dart';
import 'package:universy/model/institution/commission.dart';
import 'package:universy/model/institution/course.dart';
import 'package:universy/model/institution/coursing_period.dart';
import 'package:universy/model/institution/professor.dart';
import 'package:universy/model/institution/schedule.dart';
import 'package:universy/model/institution/subject.dart';
import 'package:universy/model/student/schedule.dart';
import 'package:universy/model/subject.dart';
import 'package:universy/text/text.dart';
import 'package:universy/util/object.dart';
import 'package:universy/widgets/buttons/uvsy/cancel.dart';
import 'package:universy/widgets/buttons/uvsy/save.dart';
import 'package:universy/widgets/dialog/title.dart';
import 'package:universy/widgets/paddings/edge.dart';

import '../widgets/course_info.dart';

const double SEPARATOR_SPACE = 15;
const int FIRST_ELEMENT_INDEX = 0;

const List<int> LEVELS_MOCK = [1, 2, 3, 4, 5];
List<InstitutionSubject> subjectsMock = [
  InstitutionSubject('subject_1', 'Matemática Discreta', 'this.codename', 1,
      'this.programId', 1, 1, false, []),
  InstitutionSubject('subject_2', 'Sistemas y Organizaciones', 'this.codename',
      1, 'this.programId', 1, 1, false, []),
];

List<Schedule> schedulesMocks = [
  Schedule('Lunes', 'Aula 4', 1800, 2150),
  Schedule('Jueves', 'Aula 4', 1730, 2300),
];

List<Professor> professorMocks = [
  Professor('Caccialupi', 'Maximiliano'),
  Professor('X', 'Profesor'),
];

List<CoursingPeriod> coursingPeriodsMock = [
  CoursingPeriod(schedulesMocks, professorMocks, 'beginMonth', 'endMonth'),
  CoursingPeriod(schedulesMocks, professorMocks, 'beginMonth', 'endMonth'),
  CoursingPeriod(schedulesMocks, professorMocks, 'beginMonth', 'endMonth'),
  CoursingPeriod(schedulesMocks, professorMocks, 'beginMonth', 'endMonth'),
];

List<Course> coursesMocks = [
  Course('this._courseId', 'commission_1', 'subject_1', coursingPeriodsMock),
  Course('this._courseId', 'commission_2', 'subject_2', coursingPeriodsMock),
];
List<Commission> commissionsMocks = [
  Commission('commission_1', '1k1', 'this.programId', 1),
  Commission('commission_2', '1k2', 'this.programId', 1),
];

class SelectCourseWidgetDialog extends StatefulWidget {
  final List<int> _levels;
  final List<InstitutionSubject> _subjects;
  final List<Course> _courses;
  final List<Commission> _commissions;
  final Function(ScheduleScratchCourse) _onConfirm;
  final Function() _onCancel;

  //TODO: Remove mocks
  SelectCourseWidgetDialog({
    @required List<int> levels,
    @required List<InstitutionSubject> subjects,
    @required List<Course> courses,
    @required List<Commission> commissions,
    @required Function(ScheduleScratchCourse) onConfirm,
    @required Function() onCancel,
  })  : this._levels = LEVELS_MOCK,
        this._subjects = subjectsMock,
        this._courses = coursesMocks,
        this._commissions = commissionsMocks,
        this._onConfirm = onConfirm,
        this._onCancel = onCancel,
        super();

  @override
  State<SelectCourseWidgetDialog> createState() {
    return SelectCourseWidgetState(this._levels, this._subjects, this._courses,
        this._commissions, this._onConfirm, this._onCancel);
  }
}

class SelectCourseWidgetState extends State<SelectCourseWidgetDialog> {
  List<int> _levels;
  List<InstitutionSubject> _subjects;
  List<InstitutionSubject> _subjectsOnDisplay;
  List<Course> _courses;
  List<Commission> _commissions;
  List<ScheduleScratchCourse> _scratchCourses;
  List<ScheduleScratchCourse> _scratchCoursesOnDisplay;
  ScheduleScratchCourse _selectedScratchCourse;
  int _selectedLevel;
  InstitutionSubject _selectedSubject;
  Function(ScheduleScratchCourse) _onConfirm;
  Function() _onCancel;

  SelectCourseWidgetState(this._levels, this._subjects, this._courses,
      this._commissions, this._onConfirm, this._onCancel);

  @override
  void initState() {
    _generateScratchCourses();
    _selectedLevel = _levels[FIRST_ELEMENT_INDEX];
    _generateSubjectsOnDisplay(_selectedLevel);
    super.initState();
  }

  void _generateScratchCourses() {
    List<ScheduleScratchCourse> newScratchCourses = [];
    _courses.forEach((Course course) {
      var generator =
          ScheduleScratchCourseListGenerator(_subjects, _commissions, course);
      var scratchCourseListFragment = generator.generate();
      if (notNull(scratchCourseListFragment)) {
        newScratchCourses.addAll(scratchCourseListFragment);
      }
    });
    setState(() {
      _scratchCourses = newScratchCourses;
      _scratchCoursesOnDisplay = [...newScratchCourses];
      if (newScratchCourses.length > 0) {
        _selectedScratchCourse = newScratchCourses[FIRST_ELEMENT_INDEX];
      }
    });
  }

  void _generateSubjectsOnDisplay(int level) {
    var filteredSubjects = _subjects
        .where((InstitutionSubject subject) => subject.level == level)
        .toList();

    if (filteredSubjects.length > 0) {
      _selectSubject(filteredSubjects[FIRST_ELEMENT_INDEX]);
    } else {
      _selectSubject(null);
    }
    _selectScratchCourse(null);
    setState(() {
      _subjectsOnDisplay = filteredSubjects;
    });
  }

  void _selectScratchCourse(ScheduleScratchCourse scheduleScratchCourse) {
    setState(() {
      _selectedScratchCourse = scheduleScratchCourse;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TitleDialog(
      title: AppText.getInstance()
          .get("student.schedule.selectCourseDialog.alertTitle"),
      content: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildDropDowns(),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: _buildScratchCoursesList(),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        SaveButton(
          onSave: _handleOnSave,
        ),
        CancelButton(
          onCancel: _onCancel,
        )
      ],
    );
  }

  void _handleOnSave() {
    _onConfirm(_selectedScratchCourse);
  }

  Widget _buildScratchCoursesList() {
    return Container(
        height: 300.0, // Change as per your requirement
        width: 300.0, // Change as per your requirement
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, position) {
            return _buildCourseInfoCard(_scratchCoursesOnDisplay[position]);
          },
          itemCount: _scratchCoursesOnDisplay.length,
        ));
  }

  Widget _buildCourseInfoCard(ScheduleScratchCourse scheduleScratchCourse) {
    bool isCourseSelected = scheduleScratchCourse == _selectedScratchCourse;
    return SymmetricEdgePaddingWidget.vertical(
      paddingValue: 6,
      child: CourseInfoCardWidget(
        scratchCourse: scheduleScratchCourse,
        onTap: _selectScratchCourse,
        isSelected: isCourseSelected,
      ),
    );
  }

  Widget _buildDropDowns() {
    return (Row(
      children: <Widget>[
        Expanded(
          child: _buildLevelDropDown(),
          flex: 20,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: _buildSubjectDropDown(),
          flex: 70,
        ),
      ],
    ));
  }

  Widget _buildLevelDropDown() {
    return (DropdownButtonFormField(
      decoration: InputDecoration(
        labelText: AppText.getInstance()
            .get("student.schedule.selectCourseDialog.level"),
      ),
      onChanged: _onLevelDropdownChange,
      isExpanded: true,
      value: _selectedLevel,
      items: _levels.map<DropdownMenuItem<int>>((int level) {
        return DropdownMenuItem<int>(
          value: level,
          child: Text(
            level.toString(),
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList(),
    ));
  }

  void _onLevelDropdownChange(int newLevel) {
    if (newLevel != _selectedLevel) {
      setState(() {
        _selectedLevel = newLevel;
      });
      _generateSubjectsOnDisplay(newLevel);
    }
  }

  Widget _buildSubjectDropDown() {
    return (DropdownButtonFormField(
      decoration: InputDecoration(
        labelText: AppText.getInstance()
            .get("student.schedule.selectCourseDialog.subject"),
      ),
      onChanged: _onSubjectDropdownChange,
      value: _selectedSubject,
      isExpanded: true,
      items: _subjectsOnDisplay.map<DropdownMenuItem<InstitutionSubject>>(
          (InstitutionSubject subject) {
        return DropdownMenuItem<InstitutionSubject>(
          value: subject,
          child: Text(subject.name, overflow: TextOverflow.ellipsis),
        );
      }).toList(),
    ));
  }

  void _onSubjectDropdownChange(InstitutionSubject newSubject) {
    _selectSubject(newSubject);
    _updateCoursesOnDisplay(newSubject);
  }

  void _selectSubject(InstitutionSubject newSubject) {
    setState(() {
      _selectedSubject = newSubject;
    });
  }

  void _updateCoursesOnDisplay(InstitutionSubject newSubject) {
    List<ScheduleScratchCourse> filteredScratchCourses = _scratchCourses
        .where((ScheduleScratchCourse scheduleScratchCourse) =>
            scheduleScratchCourse.subjectId == newSubject.id)
        .toList();

    setState(() {
      _scratchCoursesOnDisplay = filteredScratchCourses;
    });
    if (filteredScratchCourses.length > 0) {
      _selectScratchCourse(filteredScratchCourses[FIRST_ELEMENT_INDEX]);
    }
  }
}
