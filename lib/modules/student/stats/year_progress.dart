import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:universy/business/correlatives/validator.dart';
import 'package:universy/business/subjects/calculator/calculator.dart';
import 'package:universy/business/subjects/classifier/result.dart';
import 'package:universy/business/subjects/classifier/year_classifier.dart';
import 'package:universy/constants/subject_level_color.dart';
import 'package:universy/model/subject.dart';
import 'package:universy/modules/student/subjects/subject/icon.dart';
import 'package:universy/text/text.dart';
import 'package:universy/util/object.dart';
import 'package:universy/widgets/inkwell/clipped.dart';
import 'package:universy/widgets/paddings/edge.dart';

class YearProgressChart extends StatefulWidget {
  final List<Subject> _subjects;
  final CorrelativesValidator _correlativesValidator;

  const YearProgressChart(
      {Key key,
      List<Subject> subjects,
      CorrelativesValidator correlativesValidator})
      : this._subjects = subjects,
        this._correlativesValidator = correlativesValidator,
        super(key: key);

  @override
  _YearProgressChartState createState() => _YearProgressChartState();
}

class _YearProgressChartState extends State<YearProgressChart> {
  ScrollController _scrollController;
  List<Subject> _subjects;
  CorrelativesValidator _correlativesValidator;

  @override
  void initState() {
    this._subjects = widget._subjects;
    this._correlativesValidator = widget._correlativesValidator;
    this._scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    this._subjects = null;
    this._scrollController = null;
    this._correlativesValidator = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<CorrelativesValidator>.value(
      value: _correlativesValidator,
      child: Column(
        children: <Widget>[
          Expanded(child: _buildYearsChartTitle(), flex: 1),
          Expanded(child: _buildYearsChartBody(), flex: 9),
        ],
      ),
    );
  }

  Widget _buildYearsChartTitle() {
    return OnlyEdgePaddedWidget.top(
      padding: 20.0,
      child: Text(
          AppText.getInstance().get("student.stats.view.yearProgress.title"),
          textAlign: TextAlign.center,
          style: Theme.of(context).primaryTextTheme.headline4,
          overflow: TextOverflow.clip),
    );
  }

  Widget _buildYearsChartBody() {
    SubjectByYearResult subjectByYearResult =
        SubjectByYearClassifier().classify(_subjects);
    return Container(
      child: FadingEdgeScrollView.fromScrollView(
        child: ListView.builder(
          controller: _scrollController,
          itemBuilder: (BuildContext context, int index) {
            int year = index + 1;
            GlobalKey yearKey = GlobalKey();
            return ProgressYearEntry(
              expansionKey: yearKey,
              year: year,
              subjects: subjectByYearResult.getSubjects(year),
              onExpansionChange: (isExpanded) =>
                  _scrollToSelectedContent(isExpanded, year, yearKey),
            );
          },
          itemCount: subjectByYearResult.numberOfYears(),
        ),
      ),
    );
  }

  void _scrollToSelectedContent(bool isExpanded, int index, GlobalKey myKey) {
    final keyContext = myKey.currentContext;

    if (notNull(keyContext)) {
      final box = keyContext.findRenderObject() as RenderBox;

      _scrollController.animateTo(
          isExpanded ? (box.size.height * index) : _scrollController.offset,
          duration: Duration(milliseconds: 500),
          curve: Curves.linear);
    }
  }
}

class ProgressYearEntry extends StatelessWidget {
  static const ITEM_BACKGROUND_COLOR = Colors.white70;
  static const EXPANDED_ITEM_BACKGROUND_COLOR = Color(0xFFf7f7f7);
  final int year;
  final List<Subject> subjects;
  final Function(bool isExpanded) onExpansionChange;
  final Key expansionKey;

  const ProgressYearEntry(
      {Key key,
      this.year,
      this.subjects,
      this.onExpansionChange,
      this.expansionKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      key: expansionKey,
      onExpansionChanged: onExpansionChange,
      backgroundColor: EXPANDED_ITEM_BACKGROUND_COLOR,
      title: _buildTitle(),
      children: [
        _buildListOfSubjects(),
      ],
    );
  }

  Widget _buildTitle() {
    String yearText = "Año";
    String tileTitle = "$year° $yearText";
    return Row(
      children: <Widget>[
        Text(tileTitle),
        SizedBox(width: 110),
        Expanded(
          child: _getProgressPercentageBar(subjects),
        )
      ],
    );
  }

  Widget _buildListOfSubjects() {
    if (subjects.isNotEmpty) {
      return SymmetricEdgePaddingWidget.vertical(
        paddingValue: 20,
        child: Column(
          children: subjects
              .map((sub) =>
                  StudentProgressCardWidget(subject: sub, onCardTap: (c, s) {}))
              .toList(),
        ),
      );
    } else {
      return Container(
        child: Text(AppText.getInstance()
            .get("student.stats.view.yearProgress.noSubjects")),
      );
    }
  }

  Widget _getProgressPercentageBar(List<Subject> subjects) {
    SubjectCalculator progressCalculator = SubjectCalculator(subjects);
    double progress = progressCalculator.calculateProgress();
    int progressInPercentage = progressCalculator.calculatePercentage();
    return LinearPercentIndicator(
      width: 125,
      animation: true,
      lineHeight: 20.0,
      animationDuration: 500,
      percent: progress,
      center: Text("$progressInPercentage %"),
      linearStrokeCap: LinearStrokeCap.roundAll,
      progressColor: Colors.amber,
    );
  }
}

class StudentProgressCardWidget extends StatelessWidget {
  final Subject _subject;
  final SubjectCardTap _onCardTap;

  const StudentProgressCardWidget(
      {Key key, Subject subject, SubjectCardTap onCardTap})
      : this._subject = subject,
        this._onCardTap = onCardTap,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return EdgePaddingWidget(EdgeInsets.all(5.0), getSubjectCard(context));
  }

  Widget getSubjectCard(BuildContext context) {
    int level = _subject.level;
    Color splashColor = getLevelColor(level);
    return Center(
      child: ClippedInkWell(
        onTap: onTap(context),
        splashColor: splashColor,
        child: Container(
          color: _getSubjectColorBackground(context),
          width: 300,
          height: 75,
          child: Row(
            children: <Widget>[
              Expanded(child: _getSubjectWidget(context), flex: 4),
              VerticalDivider(width: 2),
              Expanded(child: getSubjectName(), flex: 12)
            ],
          ),
        ),
      ),
    );
  }

  Widget getColorTag(Color color) {
    return SizedBox(child: Container(color: color));
  }

  Widget getSubjectName() {
    return OnlyEdgePaddedWidget.left(
        padding: 16,
        child: Container(
            child: Text(_subject.name), alignment: Alignment.centerLeft));
  }

  Widget _getSubjectWidget(BuildContext context) {
    var correlativesValidator =
        Provider.of<CorrelativesValidator>(context, listen: false);
    return Center(
        child: Icon(SubjectIconResolver(correlativesValidator)
            .getSubjectIcon(_subject)));
  }

  VoidCallback onTap(BuildContext context) {
    return () => _onCardTap(context, _subject);
  }

  Color _getSubjectColorBackground(BuildContext context) {
    var correlativesValidator =
        Provider.of<CorrelativesValidator>(context, listen: false);
    SubjectColorResolver subjectColorResolver =
        SubjectColorResolver(correlativesValidator);
    return subjectColorResolver.getColorBackground(_subject);
  }
}

typedef SubjectCardTap = void Function(BuildContext context, Subject subject);

class SubjectColorResolver {
  final CorrelativesValidator correlativesValidator;

  SubjectColorResolver(this.correlativesValidator);

  Color getColorBackground(Subject subject) {
    if (subject.isApproved()) {
      return Color(0xffFFE767);
    } else if (subject.isRegular() || subject.isTaking()) {
      return Colors.white;
    } else if (!canTake(subject)) {
      return Color(0xFFB8C7CB).withOpacity(0.8);
    } else {
      return Colors.white;
    }
  }

  bool canTake(Subject subject) {
    var correlativeValidation = correlativesValidator.canTake(subject);
    return correlativeValidation?.isValid ?? false;
  }
}
