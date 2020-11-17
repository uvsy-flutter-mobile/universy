import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/model/student/schedule.dart';
import 'package:universy/modules/student/schedule/bloc/cubit.dart';
import 'package:universy/modules/student/schedule/widgets/add_scratch_button.dart';
import 'package:universy/modules/student/schedule/widgets/schedule_title.dart';
import 'package:universy/modules/student/schedule/schedule_list.dart';
import 'package:universy/text/text.dart';

const NO_SCHEDULES_AMOUNT = 0;
const ONLY_ONE_SCHEDULE_AMOUNT = 1;

class DisplayScratchesWidget extends StatelessWidget {
  final List<StudentScheduleScratch> _scheduleScratches;

  const DisplayScratchesWidget(
      {Key key, @required List<StudentScheduleScratch> scheduleScratches})
      : this._scheduleScratches = scheduleScratches,
        super(key: key);

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
              _buildScratchesList(context)
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
    int amountOfScratches = _scheduleScratches.length;

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

  Widget _buildScratchesList(BuildContext context) {
    ScheduleCubit cubit = BlocProvider.of<ScheduleCubit>(context);
    return StudentScheduleListWidget(
        scheduleScratches: _scheduleScratches, cubit: cubit);
  }
}
