import 'package:flutter/material.dart';
import 'package:universy/business/subjects/calculator/calculator.dart';
import 'package:universy/model/subject.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/paddings/edge.dart';

class ScoreAverageChart extends StatelessWidget {
  final List<Subject> _subjects;
  static const AVERAGE_DECIMALS = 2;
  static const AVERAGE_DEFAULT = 0.00;

  const ScoreAverageChart({Key key, List<Subject> subjects})
      : this._subjects = subjects,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return _validateAverage(context);
  }

  Widget _validateAverage(BuildContext context) {
    double average = SubjectCalculator(_subjects).calculateAverage();
    if (average == AVERAGE_DEFAULT) {
      return AllEdgePaddedWidget(
          padding: 30.0,
          child: _buildAverageTitle(
              context,
              AppText.getInstance()
                  .get("student.stats.view.charts.average.notNotesAdded")));
    } else {
      return _buildAverage(context, average);
    }
  }

  Widget _buildAverage(BuildContext context, double average) {
    return Container(
      child: CircleAvatar(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildAverageTitle(
                  context,
                  AppText.getInstance()
                      .get("student.stats.view.charts.average.title")),
              _buildAverageValue(context, average)
            ],
          ),
          minRadius: 90,
          backgroundColor: Colors.white),
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Color(0xfff0f0f0), // border color
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildAverageTitle(BuildContext context, String title) {
    return AllEdgePaddedWidget(
      padding: 10.0,
      child: Text(
        title,
        style: Theme.of(context).primaryTextTheme.subtitle2,
        overflow: TextOverflow.clip,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildAverageValue(BuildContext context, double average) {
    return Text(average.toStringAsFixed(AVERAGE_DECIMALS),
        style: Theme.of(context).primaryTextTheme.headline3);
  }
}
