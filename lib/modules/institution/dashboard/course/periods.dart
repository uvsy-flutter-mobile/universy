import 'package:flutter/material.dart';
import 'package:universy/model/institution/coursing_period.dart';
import 'package:universy/modules/institution/dashboard/course/periods/professors.dart';
import 'package:universy/modules/institution/dashboard/course/periods/schedule.dart';
import 'package:universy/text/formaters/couring_period.dart';
import 'package:universy/widgets/cards/rectangular.dart';
import 'package:universy/widgets/paddings/edge.dart';

class PeriodInformationItem extends StatelessWidget {
  final CoursingPeriod _period;

  PeriodInformationItem({Key key, @required CoursingPeriod period})
      : this._period = period,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularRoundedRectangleCard(
      radius: 21.0,
      color: Colors.white,
      child: Column(
        children: <Widget>[
          _buildPeriodRangeTitle(),
          ScheduleInformationWidget(
            schedules: _period.scheduleList,
          ),
          ProfessorListWidget(professors: _period.professors)
        ],
      ),
    );
  }

  Widget _buildPeriodRangeTitle() {
    return Container(
      child: OnlyEdgePaddedWidget.top(
        padding: 15,
        child: SymmetricEdgePaddingWidget.horizontal(
          paddingValue: 15,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              PeriodRangeFormatter(_period).format(),
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
