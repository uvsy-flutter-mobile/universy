import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:universy/business/subjects/calculator/calculator.dart';
import 'package:universy/business/subjects/classifier/state_classifier.dart';
import 'package:universy/business/subjects/classifier/type_classifier.dart';
import 'package:universy/model/institution/program.dart';
import 'package:universy/model/subject.dart';
import 'package:universy/modules/student/stats/average_chart.dart';
import 'package:universy/modules/student/stats/career_state_chart.dart';
import 'package:universy/modules/student/stats/points_hours_charts.dart';
import 'package:universy/modules/student/stats/progress_chart.dart';
import 'package:universy/services/factory.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/cards/rectangular.dart';
import 'package:universy/widgets/future/future_widget.dart';
import 'package:universy/widgets/paddings/edge.dart';

List<Widget> charts = [];

class DisplayCharts extends StatelessWidget {
  final List<Subject> _subjects;
  static const AVERAGE_DECIMALS = 2;
  static const AVERAGE_DEFAULT = 0.00;

  const DisplayCharts({Key key, @required List<Subject> subjects})
      : this._subjects = subjects,
        super(key: key);

  Widget build(BuildContext context) {
    return FutureWidget(
        fromFuture: _getProgram(context),
        onData: (program) => _buildModule(context, program));
  }

  Widget _buildModule(BuildContext context, InstitutionProgram program) {
    charts.clear();
    charts = _getCharts(program);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        OnlyEdgePaddedWidget.top(
            padding: 20.0,
            child: Text(
              AppText.getInstance().get("student.stats.view.charts.title"),
              style: Theme.of(context).primaryTextTheme.headline4,
            )),
        _buildScoreAverageChart(),
        _buildCareerState(),
        Expanded(child: _buildCharts(context, program, charts), flex: 5),
      ],
    );
  }

  Widget _buildCareerState() {
    return CareerStateChart(subjects: _subjects);
  }

  Widget _buildCharts(
      BuildContext context, InstitutionProgram program, List<Widget> charts) {
    return SymmetricEdgePaddingWidget.horizontal(
      paddingValue: 12.0,
      child: StaggeredGridView.countBuilder(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
        mainAxisSpacing: 2.0,
        crossAxisCount: 4,
        crossAxisSpacing: 1.5,
        itemCount: charts.length,
        itemBuilder: _chartBuilder,
      ),
    );
  }

  Widget _chartBuilder(BuildContext context, int count) {
    var _chartToBuild = charts[count];
    return _buildChartWidget(_chartToBuild);
  }

  List<Widget> _getCharts(InstitutionProgram program) {
    SubjectByStateClassifier subjectClassifier = SubjectByStateClassifier();
    var classifierResult = subjectClassifier.classify(_subjects);
    SubjectCalculator subjectCalculator =
        SubjectCalculator(classifierResult.approved);

    int completedPoints = subjectCalculator.getPoints();
    int completedHours = subjectCalculator.getHours();

    charts.add(_buildOptativeProgressChart());
    charts.add(_buildMandatoryProgressChart());

    if (program.points != 0) {
      charts.add(_buildPointsChart(completedPoints, program));
    }

    if (program.hours != 0) {
      charts.add(_buildHoursChart(completedHours, program));
    }
    return charts;
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
    SubjectByTypeClassifier subjectByTypeClassifier = SubjectByTypeClassifier();
    var classifierTypeResult = subjectByTypeClassifier.classify(_subjects);
    return ProgressChart(
        subjects: classifierTypeResult.optative,
        title: AppText.getInstance()
            .get("student.stats.view.charts.approvedOptativeSubjects"),
        color: Colors.lightBlue);
  }

  Widget _buildMandatoryProgressChart() {
    SubjectByTypeClassifier subjectClassifier = SubjectByTypeClassifier();
    var classifierResult = subjectClassifier.classify(_subjects);
    return ProgressChart(
        subjects: classifierResult.mandatory,
        title: AppText.getInstance()
            .get("student.stats.view.charts.approvedMandatorySubjects"),
        color: Colors.amber);
  }

  Widget _buildPointsChart(int completedPoints, InstitutionProgram program) {
    return PointsAndHoursChart(
        program: program,
        completed: completedPoints,
        title: AppText.getInstance()
            .get("student.stats.view.charts.completedPoints"),
        isHoursChart: false);
  }

  Widget _buildHoursChart(int completedHours, InstitutionProgram program) {
    return PointsAndHoursChart(
        program: program,
        completed: completedHours,
        title: AppText.getInstance()
            .get("student.stats.view.charts.completedHours"),
        isHoursChart: true);
  }

  Future<InstitutionProgram> _getProgram(BuildContext context) async {
    //TODO: VER CON GON
    var sessionFactory = Provider.of<ServiceFactory>(context, listen: false);
    var studentService = sessionFactory.studentCareerService();
    var programId = await studentService.getCurrentProgram();
    return sessionFactory.institutionService().getProgram(programId);
  }
}
