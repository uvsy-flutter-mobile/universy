import 'package:flutter/material.dart';
import 'package:universy/modules/student/schedule/widgets/scratch_form.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/buttons/outlined/custom_icon.dart';
import 'package:universy/widgets/buttons/uvsy/cancel.dart';
import 'package:universy/widgets/buttons/uvsy/save.dart';
import 'package:universy/widgets/dialog/title.dart';

class AddScratchButton extends StatelessWidget {
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CustomOutlinedButtonIcon(
        iconData: Icons.add,
        onPressed: () =>
            _openNewScratch(context), //TODO: modal crear un nuevo borrador
        labelText: AppText.getInstance().get("student.schedule.addNewSchedule"),
        buttonTextStyle: Theme.of(context).textTheme.button,
        color: Theme.of(context).buttonColor,
      ),
    );
  }

  void _openNewScratch(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => TitleDialog(
        title: AppText.getInstance()
            .get("student.schedule.createScratchDialog.alertTitle"),
        content: ScratchForm(),
        actions: <Widget>[SaveButton(), CancelButton()],
      ),
    );
  }
}
