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
  final Function(StudentScheduleScratch) _onDelete;
  final Function(StudentScheduleScratch) _onTap;

  ScheduleCard({
    @required StudentScheduleScratch studentScheduleScratch,
    Function(StudentScheduleScratch) onDelete,
    Function(StudentScheduleScratch) onTap,
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
        onTap: () => this._onTap(this._studentScheduleScratch),
        child: AllEdgePaddedWidget(
          padding: 9.0,
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
                scheduleLeyend: _buildScheduleLeyend(),
              )),
              SizedBox(
                width: 10,
              ),
              IconButton(
                icon: Icon(Icons.delete),
                color: Colors.black54,
                onPressed: () => this._onDelete(this._studentScheduleScratch),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _buildScheduleLeyend() {
    return ScheduleScratchTimeRangeFormatter(this._studentScheduleScratch)
        .format();
  }
}

class ScheduleInfo extends StatelessWidget {
  final String _scheduleName;
  final String _scheduleLeyend;

  ScheduleInfo({String scheduleName, String scheduleLeyend})
      : this._scheduleName = scheduleName,
        this._scheduleLeyend = scheduleLeyend,
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
          this._scheduleLeyend,
          style: Theme.of(context).textTheme.caption,
        )
      ],
    );
  }
}
