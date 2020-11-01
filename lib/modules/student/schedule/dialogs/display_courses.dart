import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:universy/business/schedule_scratch/course_list_generator.dart';
import 'package:universy/model/institution/commission.dart';
import 'package:universy/model/institution/course.dart';
import 'package:universy/model/institution/coursing_period.dart';
import 'package:universy/model/institution/subject.dart';
import 'package:universy/model/student/schedule.dart';
import 'package:universy/model/subject.dart';
import 'package:universy/modules/institution/dashboard/subjects/courses/courses_list.dart';
import 'package:universy/modules/institution/dashboard/subjects/courses/courses_list.dart';
import 'package:universy/modules/institution/dashboard/subjects/courses/courses_list.dart';
import 'package:universy/modules/institution/dashboard/subjects/courses/courses_list.dart';
import 'package:universy/modules/student/schedule/widgets/scratch_course_card.dart';
import 'package:universy/text/text.dart';
import 'package:universy/util/object.dart';
import 'package:universy/widgets/buttons/uvsy/cancel.dart';
import 'package:universy/widgets/buttons/uvsy/save.dart';
import 'package:universy/widgets/dialog/title.dart';
import 'package:universy/widgets/paddings/edge.dart';

import '../widgets/course_info.dart';

class DisplayCoursesDialogWidget extends StatefulWidget {
  final List<ScheduleScratchCourse> _scheduleScratchCourse;
  final Function(List<ScheduleScratchCourse>) _onConfirm;
  final Function() _onCancel;

  DisplayCoursesDialogWidget({
    @required List<ScheduleScratchCourse> scheduleScratchCourse,
    @required Function(List<ScheduleScratchCourse>) onConfirm,
    @required Function() onCancel,
  })  : this._scheduleScratchCourse = [...scheduleScratchCourse],
        this._onConfirm = onConfirm,
        this._onCancel = onCancel,
        super();

  @override
  State<DisplayCoursesDialogWidget> createState() {
    return DisplayCoursesWidgetState(
        this._scheduleScratchCourse, this._onConfirm, this._onCancel);
  }
}

class DisplayCoursesWidgetState extends State<DisplayCoursesDialogWidget> {
  final List<ScheduleScratchCourse> _scheduleScratchCourse;
  final Function(List<ScheduleScratchCourse>) _onConfirm;
  final Function() _onCancel;
  List<ScheduleScratchCourse> _scheduleScratchCourseOnDisplay;

  DisplayCoursesWidgetState(
      this._scheduleScratchCourse, this._onConfirm, this._onCancel);

  @override
  void initState() {
    _scheduleScratchCourseOnDisplay = [..._scheduleScratchCourse];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TitleDialog(
      title: AppText.getInstance()
          .get("student.schedule.displayCoursesDialog.alertTitle"),
      content: Container(
        padding: EdgeInsets.all(8),
        child: _buildScratchCourseCards(),
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
    _onConfirm(_scheduleScratchCourseOnDisplay);
  }

  Widget _buildScratchCourseCards() {
    return Container(
        height: 300.0, // Change as per your requirement
        width: 300.0, // Change as per your requirement
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(vertical: 8),
          itemBuilder: (context, position) {
            return ScratchCourseCard(
              scheduleScratchCourse: _scheduleScratchCourseOnDisplay[position],
              onRemove: _removeScratchFromList,
            );
          },
          itemCount: _scheduleScratchCourseOnDisplay.length,
        ));
  }

  void _removeScratchFromList(ScheduleScratchCourse courseToRemove) {
    setState(() {
      _scheduleScratchCourseOnDisplay.remove(courseToRemove);
    });
  }
}
