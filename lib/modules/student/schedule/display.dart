import 'package:flutter/material.dart';
import 'package:universy/modules/student/schedule/commons.dart';
import 'package:universy/modules/student/schedule/schedule_list.dart';
import 'package:universy/text/text.dart';

const NO_SCHEDULES_AMOUNT = 0;
const ONLY_ONE_SCHEDULE_AMOUNT = 1;

class DisplayScratchesWidget extends StatelessWidget {
  /*List<StudentScheduleScratch> _scheduleScratches;

  const DisplayScratchesWidget(
      {Key key,
        @required List<StudentScheduleScratch> scheduleScratches})
      : this._scheduleScratches = scheduleScratches,
        super(key: key); */

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(45),
          child: Column(
            children: <Widget>[
              ScheduleTitle(),
              SizedBox(height: 20),
              _buildAmountScratchesText(context),
              SizedBox(height: 20),
              AddScratchButton(),
              SizedBox(height: 15),
              _buildScratchesList()
            ],
          ),
        )
      ],
    );
  }

  Widget _buildAmountScratchesText(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        _getScratchesLength(),
        textAlign: TextAlign.end,
        style: Theme.of(context).primaryTextTheme.subtitle2,
      ),
    );
  }

  String _getScratchesLength() {
    /*int amountOfScratches = _scheduleScratches.length(); */ //TODO: tomar el largo de la lista
    int amountOfScratches = 2;

    if (amountOfScratches == ONLY_ONE_SCHEDULE_AMOUNT) {
      String onlyOneScheduleMessage =
          AppText.getInstance().get("student.schedule.amounts.onlyOne");
      return "$amountOfScratches $onlyOneScheduleMessage";
    } else {
      String manySchedulesMessage =
          AppText.getInstance().get("student.schedule.amounts.many");
      return "$amountOfScratches $manySchedulesMessage";
    }
  }

  Widget _buildScratchesList() {
    return StudentScheduleListWidget(); //TODO pasarle la lista de Scratches
  }
}
