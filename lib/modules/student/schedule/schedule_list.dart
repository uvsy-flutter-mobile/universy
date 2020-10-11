import 'package:flutter/material.dart';
import 'package:universy/system/assets.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/decorations/box.dart';

const NO_SCHEDULES_AMOUNT = 0;
const ONLY_ONE_SCHEDULE_AMOUNT = 1;

class StudentScheduleListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(45),
      child: Column(
        children: <Widget>[
          Text(
            AppText.getInstance().get("student.schedule.heroText"),
            style: Theme.of(context).primaryTextTheme.headline3,
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              _getSchedulesAmountMessage(),
              textAlign: TextAlign.end,
              style: Theme.of(context).primaryTextTheme.subtitle2,
            ),
          )
        ],
      ),
    );
  }

  String _getSchedulesAmountMessage({int amountOfSchedules = 1}) {
    //TODO: Add model and verification with array length

    if (amountOfSchedules == NO_SCHEDULES_AMOUNT) {
      return AppText.getInstance().get("student.schedule.amounts.zero");
    } else if (amountOfSchedules == ONLY_ONE_SCHEDULE_AMOUNT) {
      String onlyOneScheduleMessage =
          AppText.getInstance().get("student.schedule.amounts.onlyOne");
      return "$amountOfSchedules $onlyOneScheduleMessage";
    } else {
      String manySchedulesMessage =
          AppText.getInstance().get("student.schedule.amounts.many");
      return "$amountOfSchedules $manySchedulesMessage";
    }
  }
}
