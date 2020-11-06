import 'package:flutter/material.dart';
import 'package:universy/model/institution/subject.dart';
import 'package:universy/model/student/schedule.dart';
import 'package:universy/modules/student/schedule/dialogs/display_courses.dart';
import 'package:universy/modules/student/schedule/dialogs/select_course.dart';
import 'package:universy/widgets/paddings/edge.dart';

class _ScheduleButton extends StatelessWidget {
  final String tag;
  final Color color;
  final IconData icon;
  final VoidCallback onPressed;

  const _ScheduleButton(
      {Key key, this.tag, this.color, this.icon, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: tag,
      backgroundColor: color,
      child: Icon(
        icon,
        size: 30,
      ),
      onPressed: onPressed,
    );
  }
}

class SaveScratchButton extends StatelessWidget {
  Widget build(BuildContext context) {
    return _ScheduleButton(
      tag: "saveButton",
      color: Colors.deepPurple,
      icon: Icons.check,
      /*onPressed: () => _saveScratch(context),*/
      onPressed: () => {},
    );
  }

  void _saveScratch(BuildContext context) {
    /*onPressed: () =>   BlocProvider.of<NotesCubit>(context).createScratch();*/
  }
}

class AddScheduleCourseButton extends StatelessWidget {
  final Function(ScheduleScratchCourse) _onNewCourse;
  final List<ScheduleScratchCourse> _scratchCourses;
  final List<int> _levels;
  final List<InstitutionSubject> _subjects;

  AddScheduleCourseButton({
    @required Function(ScheduleScratchCourse) onNewCourse,
    @required List<ScheduleScratchCourse> scratchCourses,
    @required List<int> levels,
    @required List<InstitutionSubject> subjects,
  })  : this._onNewCourse = onNewCourse,
        this._scratchCourses = scratchCourses,
        this._levels = levels,
        this._subjects = subjects,
        super();

  @override
  Widget build(BuildContext context) {
    return _ScheduleButton(
      tag: "addButton",
      color: Colors.amber,
      icon: Icons.add,
      onPressed: () => _addScheduleCourse(context),
    );
  }

  void _addScheduleCourse(BuildContext context) {
    showDialog(
        context: context,
        builder: (dialogContext) => SelectCourseWidgetDialog(
              scratchCourses: _scratchCourses,
              levels: _levels,
              subjects: _subjects,
              onConfirm: (ScheduleScratchCourse newCourse) {
                _onNewCourse(newCourse);
                Navigator.pop(dialogContext);
              },
              onCancel: () => Navigator.pop(dialogContext),
            ));
  }
}

/*
abstract class DeleteScratchButton extends StatelessWidget {
  Future<void> _onPressedButton(BuildContext context) async {
    bool deleteConfirmed = await _confirmDelete(context);
    if (deleteConfirmed) {
      await AsyncModalBuilder()
          .perform(_deleteScratch)
          .withTitle(_deleteMessage(context))
          .build()
          .run(context);
      await _cubit(context).fetchScratches();
    }
  }

  String _deleteMessage(BuildContext context) {
    return "Eliminando el horario";
  }

  Future<bool> _confirmDelete(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) => ScheduleConfirmMessage(
        scheduleName: "Atencion",
        alertMessage: "¿Seguro que desea eliminar?",
        confirmMessage: "Eliminar",
      ),
    ) ??
        false;
  }

  Future<void> _deleteScratch(BuildContext context) async {
    /*await _cubit(context).deleteScratch();*/
  }

  ScheduleCubit _cubit(BuildContext context) {
    return BlocProvider.of<ScheduleCubit>(context);
  }
}*/

class ViewScheduleButton extends StatelessWidget {
  final List<ScheduleScratchCourse> _scratchCoursesList;
  final Function(List<ScheduleScratchCourse>) _onUpdatedCourses;

  ViewScheduleButton(
      {@required List<ScheduleScratchCourse> scratchCoursesList,
      @required Function(List<ScheduleScratchCourse>) onUpdatedCourses})
      : this._scratchCoursesList = scratchCoursesList,
        this._onUpdatedCourses = onUpdatedCourses,
        super();

  @override
  Widget build(BuildContext context) {
    return _ScheduleButton(
      tag: "viewButton",
      color: Colors.amber,
      icon: Icons.calendar_today,
      onPressed: () => _showDisplayCourseDialog(context),
    );
  }

  void _showDisplayCourseDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (dialogContext) => DisplayCoursesDialogWidget(
              scheduleScratchCourse: _scratchCoursesList,
              onConfirm: (List<ScheduleScratchCourse> courses) {
                _onUpdatedCourses(courses);
                Navigator.pop(dialogContext);
              },
              onCancel: () => Navigator.pop(dialogContext),
            ));
  }
}

class ScheduleActionButton extends StatelessWidget {
  final List<Widget> buttons;

  const ScheduleActionButton._({Key key, this.buttons}) : super(key: key);

  factory ScheduleActionButton.create({
    @required Function(ScheduleScratchCourse) onNewCourse,
    @required List<ScheduleScratchCourse> scratchCoursesToSelect,
    @required List<int> levels,
    @required List<InstitutionSubject> subjects,
  }) {
    var buttons = [
      AddScheduleCourseButton(
        onNewCourse: onNewCourse,
        scratchCourses: scratchCoursesToSelect,
        subjects: subjects,
        levels: levels,
      ),
      SizedBox(height: 15),
      SaveScratchButton(),
    ];
    return ScheduleActionButton._(buttons: buttons);
  }

  @override
  Widget build(BuildContext context) {
    return OnlyEdgePaddedWidget.bottom(
      padding: 20,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: buttons,
      ),
    );
  }

  factory ScheduleActionButton.edit({
    @required List<ScheduleScratchCourse> scratchCourseList,
    @required Function(List<ScheduleScratchCourse>) onUpdatedCourses,
    @required Function(ScheduleScratchCourse) onNewCourse,
    @required List<ScheduleScratchCourse> scratchCoursesToSelect,
    @required List<int> levels,
    @required List<InstitutionSubject> subjects,
  }) {
    var buttons = [
      AddScheduleCourseButton(
        onNewCourse: onNewCourse,
        scratchCourses: scratchCoursesToSelect,
        subjects: subjects,
        levels: levels,
      ),
      SizedBox(height: 15),
      ViewScheduleButton(
          scratchCoursesList: scratchCourseList,
          onUpdatedCourses: onUpdatedCourses),
      SizedBox(height: 15),
      SaveScratchButton(),
    ];
    return ScheduleActionButton._(buttons: buttons);
  }
}
