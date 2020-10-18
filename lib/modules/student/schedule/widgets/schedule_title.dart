import 'package:flutter/material.dart';
import 'package:universy/text/text.dart';

class ScheduleTitle extends StatelessWidget {
  Widget build(BuildContext context) {
    return Text(
      AppText.getInstance().get("student.schedule.heroText"),
      style: Theme.of(context).primaryTextTheme.headline3,
    );
  }
}
