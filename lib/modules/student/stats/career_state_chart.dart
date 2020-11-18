import 'package:flutter/material.dart';
import 'package:universy/business/subjects/classifier/result.dart';
import 'package:universy/business/subjects/classifier/state_classifier.dart';
import 'package:universy/business/subjects/classifier/type_classifier.dart';
import 'package:universy/model/subject.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/cards/rectangular.dart';
import 'package:universy/widgets/paddings/edge.dart';

class CareerStateChart extends StatelessWidget {
  final List<Subject> _subjects;

  const CareerStateChart({Key key, List<Subject> subjects})
      : this._subjects = subjects,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    SubjectByTypeClassifier subjectByTypeClassifier = SubjectByTypeClassifier();
    SubjectByTypeResult subjectByType =
        subjectByTypeClassifier.classify(_subjects);
    SubjectByStateClassifier subjectByStateClassifier =
        SubjectByStateClassifier();
    List<Widget> charts = [
      _buildMandatoryTaking(
          context, subjectByStateClassifier.classify(subjectByType.mandatory)),
      _buildMandatoryRegular(
          context, subjectByStateClassifier.classify(subjectByType.mandatory)),
      _buildMandatoryToTake(
          context, subjectByStateClassifier.classify(subjectByType.mandatory)),
      _buildMandatoryApproved(
          context, subjectByStateClassifier.classify(subjectByType.mandatory)),
      SizedBox(height: 10.0),
      Divider(
        color: Colors.grey,
        height: 4.0,
      ),
      SizedBox(height: 10.0),
      _buildOptativeTaking(
          context, subjectByStateClassifier.classify(subjectByType.optative)),
      _buildOptativeRegular(
          context, subjectByStateClassifier.classify(subjectByType.optative)),
      _buildOptativeApproved(
          context, subjectByStateClassifier.classify(subjectByType.optative))
    ];
    return SymmetricEdgePaddingWidget.horizontal(
      paddingValue: 9.0,
      child: Column(
        children: <Widget>[
          OnlyEdgePaddedWidget.top(
              padding: 20.0,
              child: Text(
                AppText.getInstance()
                    .get("student.stats.view.charts.titleState"),
                style: Theme.of(context).primaryTextTheme.headline4,
              )),
          Container(
            height: MediaQuery.of(context).size.height - 200,
            child: ListView(
              controller: ScrollController(),
              physics: BouncingScrollPhysics(),
              children: charts.toList(),
              shrinkWrap: true,
            ),
          )
        ],
      ),
    );
  }

//TODO: all text
  Widget _buildMandatoryTaking(
      BuildContext context, SubjectByStateResult subjectByStateResult) {
    List<Subject> subjectsTaking = subjectByStateResult.taking;
    return _buildStateWidget(
        context,
        Icon(Icons.import_contacts),
        AppText.getInstance().get("student.stats.view.charts.subjectsTaking"),
        subjectsTaking.length,
        Colors.amber);
  }

  Widget _buildMandatoryRegular(
      BuildContext context, SubjectByStateResult subjectByStateResult) {
    List<Subject> subjectsTaking = subjectByStateResult.regular;
    return _buildStateWidget(
        context,
        Icon(Icons.check),
        AppText.getInstance().get("student.stats.view.charts.subjectsRegular"),
        subjectsTaking.length,
        Colors.amber);
  }

  Widget _buildMandatoryToTake(
      BuildContext context, SubjectByStateResult subjectByStateResult) {
    List<Subject> subjectsTaking = subjectByStateResult.toTake;
    return _buildStateWidget(
        context,
        Icon(Icons.book),
        AppText.getInstance().get("student.stats.view.charts.subjectsToTake"),
        subjectsTaking.length,
        Colors.amber);
  }

  Widget _buildMandatoryApproved(
      BuildContext context, SubjectByStateResult subjectByStateResult) {
    List<Subject> subjectsApproved = subjectByStateResult.approved;
    return _buildStateWidget(
        context,
        Icon(Icons.done_all),
        AppText.getInstance().get("student.stats.view.charts.subjectsApproved"),
        subjectsApproved.length,
        Colors.amber);
  }

  Widget _buildOptativeTaking(
      BuildContext context, SubjectByStateResult subjectByStateResult) {
    List<Subject> subjectsTaking = subjectByStateResult.taking;
    return _buildStateWidget(
        context,
        Icon(Icons.import_contacts),
        AppText.getInstance().get("student.stats.view.charts.optativeTaking"),
        subjectsTaking.length,
        Colors.lightBlue);
  }

  Widget _buildOptativeRegular(
      BuildContext context, SubjectByStateResult subjectByStateResult) {
    List<Subject> subjectsTaking = subjectByStateResult.regular;
    return _buildStateWidget(
        context,
        Icon(Icons.check),
        AppText.getInstance().get("student.stats.view.charts.optativeRegular"),
        subjectsTaking.length,
        Colors.lightBlue);
  }

  Widget _buildOptativeApproved(
      BuildContext context, SubjectByStateResult subjectByStateResult) {
    List<Subject> subjectsApproved = subjectByStateResult.approved;
    return _buildStateWidget(
        context,
        Icon(Icons.done_all),
        AppText.getInstance().get("student.stats.view.charts.optativeApproved"),
        subjectsApproved.length,
        Colors.amber);
  }

  Widget _buildStateWidget(BuildContext context, Icon icon, String title,
      int total, Color colorSubject) {
    return OnlyEdgePaddedWidget.top(
      padding: 10.0,
      child: CircularRoundedRectangleCard(
          radius: 10.0,
          child: AllEdgePaddedWidget(
              padding: 10.0,
              child: Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(child: icon, flex: 2),
                  Expanded(
                      child: Text(title,
                          style: Theme.of(context).primaryTextTheme.subtitle2),
                      flex: 9),
                  Expanded(
                      child: _buildStateCount(total, colorSubject), flex: 2)
                ],
              )))),
    );
  }

  Widget _buildStateCount(int total, Color colorSubject) {
    return SymmetricEdgePaddingWidget.horizontal(
        paddingValue: 10.0,
        child: Text(total.toString(),
            textAlign: TextAlign.right,
            style: TextStyle(
                color: colorSubject,
                fontFamily: "Roboto",
                fontSize: 20.0,
                fontWeight: FontWeight.bold)));
  }
}
