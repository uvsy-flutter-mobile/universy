import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universy/model/institution/subject.dart';
import 'package:universy/modules/institution/dashboard/subjects/correlatives/correlative.dart';
import 'package:universy/text/text.dart';

class CorrelativeListWidget extends StatelessWidget {
  final List<CorrelativeItem> correlativesToTake;
  final List<CorrelativeItem> correlativesToApprove;

  const CorrelativeListWidget({
    Key key,
    this.correlativesToTake,
    this.correlativesToApprove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      children: <Widget>[
        _buildCorrelativeToTakeTitle(),
        _buildCorrelatives(correlativesToTake),
        Divider(),
        _buildCorrelativeToApproveTitle(),
        _buildCorrelatives(correlativesToApprove)
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

  Widget _buildCorrelatives(List<CorrelativeItem> correlativeResult) {
    if (correlativeResult.isEmpty) {
      return _buildNoCorrelativesText();
    } else {
      correlativeResult.sort((a, b) => a.level.compareTo(b.level));
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

  Widget _buildCorrelativeWidget(CorrelativeItem correlative) {
    return CorrelativeSubjectWidget(correlativeItem: correlative);
  }
}
