import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:universy/business/subjects/calculator/calculator.dart';
import 'package:universy/model/subject.dart';

class ProgressChart extends StatelessWidget {
  final List<Subject> _subjects;
  final String _title;
  final Color _color;
  static const CIRCLE_PROGRESS_BAR_SECONDARY_COLOR = Colors.white;

  const ProgressChart(
      {Key key, List<Subject> subjects, String title, Color color})
      : this._subjects = subjects,
        this._title = title,
        this._color = color,
        super(key: key);

  Widget build(BuildContext context) {
    double progress = SubjectCalculator(_subjects).calculateProgress();
    return CircularPercentIndicator(
      backgroundColor: CIRCLE_PROGRESS_BAR_SECONDARY_COLOR,
      radius: 110.0,
      lineWidth: 13.0,
      animation: true,
      percent: progress,
      animateFromLastPercent: true,
      center: _buildPercentProgressTitle(context, progress),
      footer: _buildProgressText(context),
      circularStrokeCap: CircularStrokeCap.round,
      arcBackgroundColor: Colors.grey,
      arcType: ArcType.FULL,
      progressColor: _color,
    );
  }

  Widget _buildProgressText(BuildContext context) {
    return Column(
      children: <Widget>[_buildDivider(), _buildTitle(context)],
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.grey,
      height: 4.0,
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      _title,
      textAlign: TextAlign.center,
      style: Theme.of(context).primaryTextTheme.subtitle2,
    );
  }

  Widget _buildPercentProgressTitle(BuildContext context, double progress) {
    int percentage = (progress * 100).toInt();
    return Text(
      "$percentage%",
      style: Theme.of(context).primaryTextTheme.headline3,
    );
  }
}
