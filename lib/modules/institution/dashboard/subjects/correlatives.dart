import 'package:flutter/material.dart';
import 'package:universy/business/subjects/classifier/correlative_classifier.dart';
import 'package:universy/model/institution/subject.dart';
import 'package:universy/modules/institution/correlatives/correlatives.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/cards/rectangular.dart';
import 'package:universy/widgets/paddings/edge.dart';

class SubjectBoardCorrelatives extends StatelessWidget {
  final InstitutionSubject subject;

  const SubjectBoardCorrelatives(
      {Key key, @required InstitutionSubject subject})
      : this.subject = subject,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularRoundedRectangleCard(
      elevation: 5,
      color: Colors.white,
      radius: 16.0,
      child: Container(
        height: 180,
        child: SymmetricEdgePaddingWidget.vertical(
          paddingValue: 5,
          child: buildCorrelatives(),
        ),
      ),
    );
  }

  Widget buildCorrelatives() {
    var classifier = InstitutionSubjectCorrelativeClassifier();
    var classifiedCorrelatives = classifier.classify(subject);
    return ListView(
      children: <Widget>[
        _buildCorrelativeToTakeTitle(),
        _buildCorrelatives(classifiedCorrelatives.correlativesToTake),
        Divider(),
        _buildCorrelativeToApproveTitle(),
        _buildCorrelatives(classifiedCorrelatives.correlativesToApprove)
      ],
    );
  }

  Widget _buildCorrelativeToTakeTitle() {
    return _buildCorrelativeTitle(
      AppText.getInstance().get("institution.dashboard.subject.label.toTake"),
    );
  }

  Widget _buildCorrelativeToApproveTitle() {
    return _buildCorrelativeTitle(
      AppText.getInstance()
          .get("institution.dashboard.subject.label.toApprove"),
    );
  }

  Widget _buildCorrelativeTitle(String title) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.orangeAccent,
        fontStyle: FontStyle.normal,
        height: 2.0,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildCorrelatives(List correlativeResult) {
    correlativeResult.sort((a, b) => a.level.compareTo(b.level));
    if (correlativeResult.isEmpty) {
      return _buildNoCorrelativesText();
    } else {
      return _buildCorrelativeList(correlativeResult);
    }
  }

  Widget _buildNoCorrelativesText() {
    return Container(
      child: Text(
        AppText.getInstance()
            .get("institution.dashboard.subject.info.correlativeNotFound"),
        style: TextStyle(fontSize: 15.0),
      ),
      alignment: Alignment.center,
    );
  }

  Widget _buildCorrelativeList(List correlativeResult) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: correlativeResult
            .map((correlative) => _buildCorrelativeWidget(correlative))
            .toList(),
      ),
    );
  }

  Widget _buildCorrelativeWidget(Correlative correlative) {
    return CorrelativeSubjectWidget(
      subject: subject,
      condition: correlative.correlativeCondition,
    );
  }
}
