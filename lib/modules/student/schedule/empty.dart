import 'package:flutter/material.dart';
import 'package:universy/modules/student/schedule/widgets/add_scratch_button.dart';
import 'package:universy/modules/student/schedule/widgets/schedule_title.dart';
import 'package:universy/text/text.dart';

class EmptyScratchesWidget extends StatelessWidget {
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
    return Container(
      padding: EdgeInsets.all(45),
      child: Column(
        children: <Widget>[
          ScheduleTitle(),
          SizedBox(height: 20),
          _buildAmountScratchesText(context),
          SizedBox(height: 20),
          AddScratchButton(),
        ],
      ),
    );
  }

  Widget _buildAmountScratchesText(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        AppText.getInstance().get("student.schedule.amounts.zero"),
        textAlign: TextAlign.end,
        style: Theme.of(context).primaryTextTheme.subtitle2,
      ),
    );
  }
}
