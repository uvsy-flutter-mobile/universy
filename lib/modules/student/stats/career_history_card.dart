import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:universy/constants/subject_level_color.dart';
import 'package:universy/modules/student/stats/career_history.dart';
import 'package:universy/system/locale.dart';
import 'package:universy/text/translators/milestones.dart';
import 'package:universy/widgets/paddings/edge.dart';

class HistoricItemCard extends StatelessWidget {
  final HistoricItem _historicItem;
  final bool _create;

  const HistoricItemCard._({Key key, HistoricItem historicItem, bool create})
      : this._historicItem = historicItem,
        this._create = create,
        super(key: key);

  factory HistoricItemCard.welcomeMessage() {
    return HistoricItemCard._(create: false);
  }

  factory HistoricItemCard.createHistoricItem(HistoricItem historicItem) {
    return HistoricItemCard._(historicItem: historicItem, create: true);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 10,
        child: Container(
          width: double.infinity,
          height: 80,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: _create ? _buildHistoricCard() : _buildWelcomeWidget(),
          ),
        ));
  }

  List<Widget> _buildWelcomeWidget() {
    return <Widget>[
      Expanded(
          child: Container(
            decoration: new BoxDecoration(
                color: Colors.orangeAccent,
                borderRadius:
                    BorderRadius.horizontal(left: Radius.circular(15))),
          ),
          flex: 1),
      Expanded(
          child: Text("Este es el punto de partida de tu carrera",
              textAlign: TextAlign.center),
          flex: 12)
    ];
  }

  List<Widget> _buildHistoricCard() {
    return <Widget>[
      Expanded(child: _buildColorTag(), flex: 1),
      Expanded(child: _buildLevel(), flex: 2),
      VerticalDivider(),
      Expanded(child: _buildItemContent(), flex: 12),
    ];
  }

  Widget _buildColorTag() {
    Color color = getLevelColor(_historicItem.level);
    return Container(
      decoration: new BoxDecoration(
          color: color,
          borderRadius: BorderRadius.horizontal(left: Radius.circular(15))),
    );
  }

  Widget _buildLevel() {
    return OnlyEdgePaddedWidget.left(
      padding: 12,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("${_historicItem.level}º"),
        ],
      ),
    );
  }

  Widget _buildItemContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildSubjectName(),
        SizedBox(height: 8),
        _buildMilestoneTypeAndDate(),
      ],
    );
  }

  Widget _buildMilestoneTypeAndDate() {
    DateFormat dateFormat =
        DateFormat("MMM yyyy", SystemLocale.getSystemLocale().toString());
    var date = dateFormat.format(_historicItem.date);
    var milestone = getMilestoneDisplayName(_historicItem.milestoneType);
    return Container(
        child: Text(
          "$milestone $date",
          style: TextStyle(color: Colors.black26),
        ),
        alignment: Alignment.bottomLeft);
  }

  Widget _buildSubjectName() {
    return Container(
        child: Text(_historicItem.subjectName), alignment: Alignment.topLeft);
  }
}
