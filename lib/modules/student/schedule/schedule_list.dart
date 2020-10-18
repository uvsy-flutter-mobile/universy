import 'package:flutter/material.dart';
import 'package:universy/model/student/schedule.dart';
import 'package:universy/modules/student/schedule/card.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/buttons/outlined/custom_icon.dart';
import 'package:universy/widgets/buttons/raised/rounded.dart';

const NO_SCHEDULES_AMOUNT = 0;
const ONLY_ONE_SCHEDULE_AMOUNT = 1;

var mockedScheduleScratchList = [
  StudentScheduleScratch('scheduleScratchId', 'userId', 'careerId', 'name,',
      1602980186767, 1602980186767, [], DateTime.now(), DateTime.now()),
  StudentScheduleScratch('scheduleScratchId', 'userId', 'careerId', 'name,',
      1602980186767, 1602980186767, [], DateTime.now(), DateTime.now()),
];

class StudentScheduleListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
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
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: CustomOutlinedButtonIcon(
                  iconData: Icons.add,
                  onPressed: () => {},
                  labelText: AppText.getInstance()
                      .get("student.schedule.addNewSchedule"),
                  buttonTextStyle: Theme.of(context).textTheme.button,
                  color: Theme.of(context).buttonColor,
                ),
              ),
              SizedBox(height: 15),
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 600),
                child: ListView(
                  children: <Widget>[
                    ScheduleCard(
                      studentScheduleScratch: mockedScheduleScratchList[0],
                      onDelete: _handleOnDeleteSchedule,
                      onTap: _handleOnTapSchedule,
                    ),
                    ScheduleCard(
                      studentScheduleScratch: mockedScheduleScratchList[1],
                      onDelete: _handleOnDeleteSchedule,
                      onTap: _handleOnTapSchedule,
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
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

  void _handleOnDeleteSchedule(StudentScheduleScratch studentScheduleScratch) {
    print('handleOnDeleteSchedule $studentScheduleScratch');
  }

  void _handleOnTapSchedule(StudentScheduleScratch studentScheduleScratch) {
    print('handleOnTapSchedule $studentScheduleScratch');
  }
}
