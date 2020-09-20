import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:universy/business/subjects/calculator/calculator.dart';
import 'package:universy/business/subjects/classifier/state_classifier.dart';
import 'package:universy/business/subjects/classifier/type_classifier.dart';
import 'package:universy/model/institution/program.dart';
import 'package:universy/model/subject.dart';
import 'package:universy/modules/student/stats/average_chart.dart';
import 'package:universy/modules/student/stats/points_hours_charts.dart';
import 'package:universy/modules/student/stats/progress_chart.dart';
import 'package:universy/services/factory.dart';
import 'package:universy/widgets/cards/rectangular.dart';
import 'package:universy/widgets/future/future_widget.dart';
import 'package:universy/widgets/paddings/edge.dart';

class DisplayCharts extends StatelessWidget {
  final List<Subject> _subjects;
  static const AVERAGE_DECIMALS = 2;
  static const AVERAGE_DEFAULT = 0.00;

  const DisplayCharts({Key key, @required List<Subject> subjects})
      : this._subjects = subjects,
        super(key: key);

  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        OnlyEdgePaddedWidget.top(
            padding: 20.0,
            child: Text(
              "Mi progreso general",
              style: Theme.of(context).primaryTextTheme.headline4,
            )),
        _buildScoreAverageChart(),
        Expanded(child: _buildCharts(context), flex: 9)
      ],
    );
  }

  Widget _buildCharts(BuildContext context) {
    return SymmetricEdgePaddingWidget.horizontal(
      paddingValue: 12.0,
      child: StaggeredGridView.countBuilder(
        physics: BouncingScrollPhysics(),
        crossAxisCount: 4,
        staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
        mainAxisSpacing: 2.0,
        crossAxisSpacing: 1.5,
        itemCount: 4,
        itemBuilder: _chartBuilder,
      ),
    );
  }

  Widget _chartBuilder(BuildContext context, int count) {
    List<Widget> charts = [
      _buildOptativeProgressChart(),
      _buildMandatoryProgressChart(),
      _buildPointsChart(context),
      _buildHoursChart(context),
    ];
    var _chartToBuild = charts[count];
    return _buildChartWidget(_chartToBuild);
  }

  Widget _buildChartWidget(Widget chart) {
    return OnlyEdgePaddedWidget.top(
      padding: 5.0,
      child: CircularRoundedRectangleCard(
          radius: 10.0,
          child: AllEdgePaddedWidget(
              padding: 5.0, child: Container(child: chart))),
    );
  }

  Widget _buildScoreAverageChart() {
    return ScoreAverageChart(subjects: _subjects);
  }

  Widget _buildOptativeProgressChart() {
    SubjectByTypeClassifier subjectClassifier = SubjectByTypeClassifier();
    var classifierResult = subjectClassifier.classify(_subjects);
    return ProgressChart(
        subjects: classifierResult.optative,
        title: "Avance de materias optativas aprobadas",
        color: Colors.lightBlue);
  }

  Widget _buildMandatoryProgressChart() {
    SubjectByTypeClassifier subjectClassifier = SubjectByTypeClassifier();
    var classifierResult = subjectClassifier.classify(_subjects);
    return ProgressChart(
        subjects: classifierResult.mandatory,
        title: "Avance de materias obligatorias aprobadas",
        color: Colors.amber);
  }

  Widget _buildPointsChart(BuildContext context) {
    SubjectByStateClassifier subjectClassifier = SubjectByStateClassifier();
    var classifierResult = subjectClassifier.classify(_subjects);
    SubjectCalculator subjectCalculator =
        SubjectCalculator(classifierResult.approved);

    int completedPoints = subjectCalculator.getPoints();
    return FutureWidget(
      fromFuture: _getProgram(context),
      onData: (data) => PointsAndHoursChart(
          program: data,
          completed: completedPoints,
          title: "Puntos Completados en la carrera",
          isHoursChart: false),
    );
  }

  Widget _buildHoursChart(BuildContext context) {
    SubjectByStateClassifier subjectClassifier = SubjectByStateClassifier();
    var classifierResult = subjectClassifier.classify(_subjects);
    SubjectCalculator subjectCalculator =
        SubjectCalculator(classifierResult.approved);

    int completedHours = subjectCalculator.getHours();
    return FutureWidget(
      fromFuture: _getProgram(context),
      onData: (data) => PointsAndHoursChart(
          program: data,
          completed: completedHours,
          title: "Horas Completados en la carrera",
          isHoursChart: true),
    );
  }

  Future<InstitutionProgram> _getProgram(BuildContext context) async {
    //TODO: VER CON GON
    var sessionFactory = Provider.of<ServiceFactory>(context, listen: false);
    var studentService = sessionFactory.studentCareerService();
    var programId = await studentService.getCurrentProgram();
    return sessionFactory.institutionService().getProgram(programId);
  }
}
