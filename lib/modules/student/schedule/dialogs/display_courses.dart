import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:universy/model/student/schedule.dart';
import 'package:universy/modules/student/schedule/widgets/scratch_course_card.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/buttons/uvsy/cancel.dart';
import 'package:universy/widgets/buttons/uvsy/save.dart';
import 'package:universy/widgets/dialog/title.dart';

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
        padding: EdgeInsets.all(3),
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
    if (_scheduleScratchCourseOnDisplay.length > 0) {
      return Container(
          height: MediaQuery.of(context).size.height - 200,
          width: MediaQuery.of(context).size.width - 100,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(vertical: 8),
            itemBuilder: (context, position) {
              return ScratchCourseCard(
                scheduleScratchCourse:
                    _scheduleScratchCourseOnDisplay[position],
                onRemove: _removeScratchFromList,
              );
            },
            itemCount: _scheduleScratchCourseOnDisplay.length,
          ));
    } else {
      return Container(
        padding: EdgeInsets.all(25),
        child: Text(
          AppText.instance
              .get("student.schedule.displayCoursesDialog.emptyCourses"),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.subtitle1,
        ),
      );
    }
  }

  void _removeScratchFromList(ScheduleScratchCourse courseToRemove) {
    setState(() {
      _scheduleScratchCourseOnDisplay.remove(courseToRemove);
    });
  }
}
