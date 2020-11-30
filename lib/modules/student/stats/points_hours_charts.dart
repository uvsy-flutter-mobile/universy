import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:universy/model/institution/program.dart';
import 'package:universy/widgets/paddings/edge.dart';

class PointsAndHoursChart extends StatelessWidget {
  final InstitutionProgram _program;
  final int _completed;
  final String _title;
  final bool _isHoursChart;

  const PointsAndHoursChart(
      {Key key,
      @required InstitutionProgram program,
      @required int completed,
      String title,
      bool isHoursChart})
      : this._program = program,
        this._completed = completed,
        this._title = title,
        this._isHoursChart = isHoursChart,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _buildChartBody(context),
            _buildChartLine(),
            _buildDivider(),
            _buildChartTitle(context)
          ]),
    );
  }

  Widget _buildChartTitle(BuildContext context) {
    return AllEdgePaddedWidget(
        padding: 10.0,
        child: Text(_title,
            overflow: TextOverflow.clip,
            textAlign: TextAlign.center,
            style: Theme.of(context).primaryTextTheme.subtitle2));
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.grey,
      height: 4.0,
    );
  }

  Widget _buildChartLine() {
    double totalPercent = _calculatePercent();
    int percentText = (totalPercent * 100).truncate();
    return AllEdgePaddedWidget(
      padding: 10.0,
      child: LinearPercentIndicator(
        percent: totalPercent,
        width: 125,
        animation: true,
        lineHeight: 20.0,
        alignment: MainAxisAlignment.center,
        animationDuration: 500,
        center: Text("$percentText %"),
        linearStrokeCap: LinearStrokeCap.roundAll,
        progressColor: Colors.lightBlue,
      ),
    );
  }

  double _calculatePercent() {
    int total = _isHoursChart ? _program.hours : _program.points;
    double percent = _completed / total;
    if (percent > 1.0) {
      percent = 1.0;
    }
    return percent;
  }

  Widget _buildChartBody(BuildContext context) {
    int total = _isHoursChart ? _program.hours : _program.points;
    return AllEdgePaddedWidget(
      padding: 10.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("$_completed de $total ",
              style: Theme.of(context).primaryTextTheme.subtitle2),
        ],
      ),
    );
  }
}
