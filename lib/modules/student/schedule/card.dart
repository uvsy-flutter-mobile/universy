import 'package:flutter/material.dart';
import 'package:universy/model/student/schedule.dart';
import 'package:universy/modules/student/schedule/schedule_list.dart';
import 'package:universy/system/assets.dart';
import 'package:universy/text/formaters/schedule_scratch.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/cards/rectangular.dart';
import 'package:universy/widgets/decorations/box.dart';
import 'package:universy/widgets/paddings/edge.dart';

class ScheduleCard extends StatelessWidget {
  final StudentScheduleScratch _studentScheduleScratch;
  final VoidCallback _onDelete;
  final VoidCallback _onTap;

  ScheduleCard({
    @required StudentScheduleScratch studentScheduleScratch,
    VoidCallback onDelete,
    VoidCallback onTap,
  })  : this._studentScheduleScratch = studentScheduleScratch,
        this._onDelete = onDelete,
        this._onTap = onTap,
        super();

  @override
  Widget build(BuildContext context) {
    return CircularRoundedRectangleCard(
      color: Colors.white,
      elevation: 2,
      radius: 8.0,
      child: InkWell(
        onTap: () => this._onTap(),
        child: AllEdgePaddedWidget(
          padding: 10.0,
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 10,
              ),
              Icon(Icons.calendar_today),
              SizedBox(
                width: 20,
              ),
              Expanded(
                  child: ScheduleInfo(
                scheduleName: this._studentScheduleScratch.name,
                scheduleLegend: _buildScheduleLegend(),
              )),
              SizedBox(
                width: 10,
              ),
              IconButton(
                icon: Icon(Icons.delete),
                color: Colors.black54,
                onPressed: () => this._onDelete(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _buildScheduleLegend() {
    ScheduleScratchTimeRangeFormatter scheduleFormatter =
        new ScheduleScratchTimeRangeFormatter();
    return scheduleFormatter.format(
        _studentScheduleScratch.beginDate, _studentScheduleScratch.endDate);
  }
}

class ScheduleInfo extends StatelessWidget {
  final String _scheduleName;
  final String _scheduleLegend;

  ScheduleInfo({String scheduleName, String scheduleLegend})
      : this._scheduleName = scheduleName,
        this._scheduleLegend = scheduleLegend,
        super();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          this._scheduleName,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          this._scheduleLegend,
          style: Theme.of(context).textTheme.caption,
        )
      ],
    );
  }
}
