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
import 'package:universy/widgets/paddings/edge.dart';

import 'course_info_card.dart';

const double SEPARATOR_SPACE = 15;
const int FIRST_ELEMENT_INDEX = 0;

const List<int> LEVELS_MOCK = [1, 2, 3, 4, 5];
List<InstitutionSubject> subjectsMock = [
  InstitutionSubject('subject_1', 'this.name', 'this.codename', 1,
      'this.programId', 1, 1, false, []),
  InstitutionSubject('subject_2', 'this.name', 'this.codename', 1,
      'this.programId', 1, 1, false, []),
];
List<Course> coursesMocks = [
  Course('this._courseId', 'commission_1', 'subject_1', []),
  Course('this._courseId', 'commission_2', 'subject_2', []),
];
List<Commission> commissionsMocks = [
  Commission('commission_1,', 'this.name', 'this.programId', 1),
  Commission('commission_2,', 'this.name', 'this.programId', 1),
];

class SelectCourseWidget extends StatefulWidget {
  final List<int> _levels;
  final List<InstitutionSubject> _subjects;
  final List<Course> _courses;
  final List<Commission> _commissions;
  final Function(ScheduleScratchCourse) _onSelectedScratchCourse;

  //TODO: Remove mocks
  SelectCourseWidget({
    @required List<int> levels,
    @required List<InstitutionSubject> subjects,
    @required List<Course> courses,
    @required List<Commission> commissions,
    @required Function(ScheduleScratchCourse) onSelectedScratchCourse,
  })  : this._levels = LEVELS_MOCK,
        this._subjects = subjectsMock,
        this._courses = coursesMocks,
        this._commissions = commissionsMocks,
        this._onSelectedScratchCourse = onSelectedScratchCourse,
        super();

  @override
  State<SelectCourseWidget> createState() {
    return SelectCourseWidgetState(this._levels, this._subjects, this._courses,
        this._commissions, this._onSelectedScratchCourse);
  }
}

class SelectCourseWidgetState extends State<SelectCourseWidget> {
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
  Function(ScheduleScratchCourse) _onSelectedScratchCourse;

  SelectCourseWidgetState(this._levels, this._subjects, this._courses,
      this._commissions, this._onSelectedScratchCourse);

  @override
  void initState() {
    _generateScratchCourses();
    _selectedLevel = _levels[FIRST_ELEMENT_INDEX];
    _generateSubjectsOnDisplay(_selectedLevel);
    _selectedSubject = _subjectsOnDisplay[FIRST_ELEMENT_INDEX];
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
    _scratchCoursesOnDisplay = [..._scratchCourses];
  }

  void _generateSubjectsOnDisplay(int level) {
    var filteredSubjects =
        _subjects.where((InstitutionSubject subject) => subject.level == level);

    setState(() {
      _subjectsOnDisplay = filteredSubjects;
      _selectedSubject = _subjectsOnDisplay[FIRST_ELEMENT_INDEX];
    });
    _selectScratchCourse(null);
  }

  void _selectScratchCourse(ScheduleScratchCourse scheduleScratchCourse) {
    setState(() {
      _selectedScratchCourse = scheduleScratchCourse;
      _onSelectedScratchCourse(scheduleScratchCourse);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(26),
      child: Column(
        children: <Widget>[
          _buildDropDowns(),
          SizedBox(
            height: 15,
          ),
          _buildScratchCoursesList()
        ],
      ),
    );
  }

  Widget _buildScratchCoursesList() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (context, position) {
        return _buildCourseInfoCard(_scratchCoursesOnDisplay[position]);
      },
      itemCount: _scratchCoursesOnDisplay.length,
    );
  }

  Widget _buildCourseInfoCard(ScheduleScratchCourse scheduleScratchCourse) {
    bool isCourseSelected = scheduleScratchCourse == _selectedScratchCourse;
    return SymmetricEdgePaddingWidget.vertical(
      paddingValue: 15,
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
        _buildLevelDropDown(),
        _buildSubjectDropDown(),
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
      items: _levels.map<DropdownMenuItem<int>>((int level) {
        return DropdownMenuItem<int>(
          value: level,
          child: Text(level.toString()),
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
            .get("student.schedule.selectCourseDialog.level"),
      ),
      onChanged: _onSubjectDropdownChange,
      items: _subjects.map<DropdownMenuItem<InstitutionSubject>>(
          (InstitutionSubject subject) {
        return DropdownMenuItem<InstitutionSubject>(
          value: subject,
          child: Text(subject.name),
        );
      }).toList(),
    ));
  }

  void _onSubjectDropdownChange(InstitutionSubject newSubject) {
    setState(() {
      _selectedSubject = newSubject;
    });
    _updateCoursesOnDisplay(newSubject);
  }

  void _updateCoursesOnDisplay(InstitutionSubject newSubject) {
    List<ScheduleScratchCourse> filteredScratchCourses = _scratchCourses.where(
        (ScheduleScratchCourse scheduleScratchCourse) =>
            scheduleScratchCourse.subjectId == newSubject.id);

    setState(() {
      _scratchCoursesOnDisplay = filteredScratchCourses;
    });
    _selectScratchCourse(filteredScratchCourses[FIRST_ELEMENT_INDEX]);
  }
}
