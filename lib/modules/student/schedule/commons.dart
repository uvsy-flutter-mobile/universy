import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/buttons/outlined/custom_icon.dart';

class AddScratchButton extends StatelessWidget {
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CustomOutlinedButtonIcon(
        iconData: Icons.add,
        onPressed: () => {},
        labelText: AppText.getInstance().get("student.schedule.addNewSchedule"),
        buttonTextStyle: Theme.of(context).textTheme.button,
        color: Theme.of(context).buttonColor,
      ),
    );
  }
}

class ScheduleTitle extends StatelessWidget {
  Widget build(BuildContext context) {
    return Text(
      AppText.getInstance().get("student.schedule.heroText"),
      style: Theme.of(context).primaryTextTheme.headline3,
    );
  }
}
