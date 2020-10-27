import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/model/student/schedule.dart';
import 'package:universy/modules/student/schedule/bloc/cubit.dart';
import 'package:universy/modules/student/schedule/card.dart';
import 'package:universy/modules/student/schedule/widgets/confirm_message.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/buttons/uvsy/cancel.dart';
import 'package:universy/widgets/buttons/uvsy/delete.dart';
import 'package:universy/widgets/dialog/title.dart';

var mockedScheduleScratchList = [
  StudentScheduleScratch(
      'scheduleScratchId',
      'Primer cuatrimestre muy largo y totalmente execsivo',
      1602980186767,
      1602980186767,
      [],
      DateTime.now(),
      DateTime.now()),
  StudentScheduleScratch('scheduleScratchId', 'name,', 1602980186767,
      1602980186767, [], DateTime.now(), DateTime.now()),
];

class StudentScheduleListWidget extends StatelessWidget {
  final List<StudentScheduleScratch> _scheduleScratches;

  const StudentScheduleListWidget(
      {Key key, @required List<StudentScheduleScratch> scheduleScratches})
      : this._scheduleScratches = scheduleScratches,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 600),
      child: ListView(
        children: <Widget>[
          ScheduleCard(
            studentScheduleScratch: mockedScheduleScratchList[0],
            onDelete: () =>
                _handleOnDeleteSchedule(mockedScheduleScratchList[0], context),
            onTap: () =>
                _handleOnTapSchedule(mockedScheduleScratchList[0], context),
          ),
          ScheduleCard(
            studentScheduleScratch: mockedScheduleScratchList[1],
            onDelete: () =>
                _handleOnDeleteSchedule(mockedScheduleScratchList[1], context),
            onTap: () =>
                _handleOnTapSchedule(mockedScheduleScratchList[1], context),
          ),
        ],
      ),
    );
  }

  void _handleOnDeleteSchedule(
      StudentScheduleScratch studentScheduleScratch, BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => TitleDialog(
        title: AppText.getInstance()
            .get("student.schedule.deleteDialog.alertTitle"),
        content: ScheduleConfirmMessage(
          scheduleName: studentScheduleScratch.name,
          alertMessage: AppText.getInstance()
              .get("student.schedule.deleteDialog.alertMessage"),
          confirmMessage: AppText.getInstance()
              .get("student.schedule.deleteDialog.confirmMessage"),
        ),
        actions: <Widget>[
          DeleteButton(
              onDelete: () => _onDeleteScheduleScratch(
                  studentScheduleScratch, dialogContext)),
          CancelButton(
            onCancel: () => _closeDeleteDialog(dialogContext),
          )
        ],
      ),
    );
  }

  void _onDeleteScheduleScratch(
      StudentScheduleScratch studentScheduleScratch, BuildContext context) {
    print('Trying To Delete: ${studentScheduleScratch.name}');
    _closeDeleteDialog(context);
  }

  void _closeDeleteDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _handleOnTapSchedule(
      StudentScheduleScratch studentScheduleScratch, BuildContext context) {
    ScheduleCubit cubit = BlocProvider.of<ScheduleCubit>(context);
    cubit.editViewScratchSchedule(studentScheduleScratch);
  }
}
