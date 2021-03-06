import 'package:flutter/material.dart';
import 'package:universy/constants/routes.dart';
import 'package:universy/modules/student/schedule/widgets/confirm_message.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/buttons/uvsy/cancel.dart';
import 'package:universy/widgets/buttons/uvsy/delete.dart';

class ScratchAppBar extends StatelessWidget {
  final String title;

  const ScratchAppBar({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(AppText.getInstance().get("student.schedule.scratchTitle")),
        leading: _buildBackButton(context));
  }

  Widget _buildBackButton(BuildContext context) {
    return BackButton(
      onPressed: () => showDialog(
          context: context,
          builder: (BuildContext context) => _buildAlertBackDialog(context)),
    );
  }

  Widget _buildAlertBackDialog(BuildContext context) {
    return AlertDialog(
      title: Text("Atención"),
      shape: _buildShape(),
      content: _buildBody(),
      actions: <Widget>[
        DeleteButton(onDelete: () => _navigateBack(context), size: 40.0),
        CancelButton(onCancel: () => Navigator.pop(context))
      ],
    );
  }

  void _navigateBack(BuildContext context) {
    Navigator.pop(context);
    Navigator.of(context).pushReplacementNamed(Routes.SCHEDULE_MODULE);
  }

  Widget _buildBody() {
    return ScheduleConfirmMessage(
      scheduleName: "$title",
      alertMessage: AppText.getInstance()
          .get("student.schedule.goBackDialog.alertMessage"),
      confirmMessage: AppText.getInstance()
          .get("student.schedule.goBackDialog.confirmMessage"),
    );
  }

  ShapeBorder _buildShape() {
    return RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0)));
  }
}

class ScheduleMainAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(AppText.getInstance().get("student.schedule.title")),
      leading: BackButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.HOME);
        },
      ),
    );
  }
}
