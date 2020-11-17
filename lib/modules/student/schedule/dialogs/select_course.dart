import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:universy/model/institution/subject.dart';
import 'package:universy/model/student/schedule.dart';
import 'package:universy/text/text.dart';
import 'package:universy/util/object.dart';
import 'package:universy/widgets/buttons/uvsy/cancel.dart';
import 'package:universy/widgets/buttons/uvsy/save.dart';
import 'package:universy/widgets/buttons/color/color_picker.dart';
import 'package:universy/widgets/dialog/title.dart';
import 'package:universy/widgets/paddings/edge.dart';

import '../widgets/course_info.dart';

const double SEPARATOR_SPACE = 15;
const int FIRST_ELEMENT_INDEX = 0;

class SelectCourseWidgetDialog extends StatefulWidget {
  final List<int> _levels;
  final List<InstitutionSubject> _subjects;
  final List<ScheduleScratchCourse> _scratchCourses;
  final Function(ScheduleScratchCourse) _onConfirm;
  final Function() _onCancel;

  SelectCourseWidgetDialog({
    @required List<int> levels,
    @required List<InstitutionSubject> subjects,
    @required List<ScheduleScratchCourse> scratchCourses,
    @required Function(ScheduleScratchCourse) onConfirm,
    @required Function() onCancel,
  })  : this._levels = levels,
        this._subjects = subjects,
        this._scratchCourses = scratchCourses,
        this._onConfirm = onConfirm,
        this._onCancel = onCancel,
        super();

  @override
  State<SelectCourseWidgetDialog> createState() {
    return SelectCourseWidgetState(this._levels, this._subjects,
        this._scratchCourses, this._onConfirm, this._onCancel);
  }
}

class SelectCourseWidgetState extends State<SelectCourseWidgetDialog> {
  final List<int> _levels;
  final List<InstitutionSubject> _subjects;
  final List<ScheduleScratchCourse> _scratchCourses;
  final Function(ScheduleScratchCourse) _onConfirm;
  final Function() _onCancel;
  List<InstitutionSubject> _subjectsOnDisplay;
  List<ScheduleScratchCourse> _scratchCoursesOnDisplay;
  ScheduleScratchCourse _selectedScratchCourse;
  int _selectedLevel;
  InstitutionSubject _selectedSubject;
  Color _selectedColor;

  SelectCourseWidgetState(this._levels, this._subjects, this._scratchCourses,
      this._onConfirm, this._onCancel);

  @override
  void initState() {
    _selectedLevel = _levels.isEmpty ? 0 : _levels[FIRST_ELEMENT_INDEX];
    _selectedColor = Colors.red;
    _generateSubjectsOnDisplay(_selectedLevel);
    super.initState();
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
      titleAction: ColorPickerButton(
        onSelectedColor: _onSelectedColor,
        initialColor: _selectedColor,
      ),
      actions: <Widget>[
        Visibility(
          visible: notNull(_selectedScratchCourse),
          child: SaveButton(
            onSave: _handleOnSave,
          ),
        ),
        CancelButton(
          onCancel: _onCancel,
        )
      ],
    );
  }

  void _onSelectedColor(Color newColor) {
    setState(() {
      _selectedColor = newColor;
    });
  }

  void _handleOnSave() {
    _selectedScratchCourse.color = _selectedColor;
    _onConfirm(_selectedScratchCourse);
  }

  Widget _buildScratchCoursesList() {
    if (_scratchCoursesOnDisplay.length > 0) {
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
    } else {
      return Container(
        padding: EdgeInsets.all(25),
        child: Text(
          AppText.instance
              .get("student.schedule.selectCourseDialog.emptyCourses"),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.subtitle1,
        ),
      );
    }
  }

  Widget _buildCourseInfoCard(ScheduleScratchCourse scheduleScratchCourse) {
    bool isCourseSelected = scheduleScratchCourse == _selectedScratchCourse;
    return SymmetricEdgePaddingWidget.vertical(
      paddingValue: 6,
      child: CourseInfoCardWidget(
          scratchCourse: scheduleScratchCourse,
          onTap: _selectScratchCourse,
          isSelected: isCourseSelected,
          selectedColor: _selectedColor),
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
    _updateCoursesOnDisplay(newSubject);
  }

  void _updateCoursesOnDisplay(InstitutionSubject newSubject) {
    if (notNull(newSubject)) {
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
    } else {
      setState(() {
        _scratchCoursesOnDisplay = [];
      });
      _selectScratchCourse(null);
    }
  }
}
