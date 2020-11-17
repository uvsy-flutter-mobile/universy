import 'package:flutter/material.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';
import 'package:universy/model/student/subject.dart';
import 'package:universy/model/subject.dart';
import 'package:universy/modules/student/stats/career_history_card.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/paddings/edge.dart';

class CareerHistory extends StatelessWidget {
  final List<Subject> _subjects;

  const CareerHistory({Key key, List<Subject> subjects})
      : this._subjects = subjects,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
            child: OnlyEdgePaddedWidget.top(
              padding: 20.0,
              child: Text(
                  AppText.getInstance()
                      .get("student.stats.view.careerHistory.title"),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).primaryTextTheme.headline4,
                  overflow: TextOverflow.clip),
            ),
            flex: 1),
        SizedBox(height: 20.0),
        Expanded(child: _buildCareerHistory(), flex: 10)
      ],
    );
  }

  TimelineModel _buildWelcomeItem(Widget historicItem) {
    return TimelineModel(historicItem,
        position: TimelineItemPosition.left,
        iconBackground: Colors.white,
        icon: Icon(Icons.flag));
  }

  List<HistoricItem> _buildCareerHistoric() {
    List<HistoricItem> historicList = List();
    List studentSubjects =
        _subjects.where((s) => s.isApproved() || s.isRegular()).toList();
    for (Subject subject in studentSubjects) {
      List regularAndApproved = subject.milestones
          .where((s) => s.isRegular() || s.isApproved())
          .toList();
      for (Milestone milestone in regularAndApproved) {
        HistoricItem milestoneItem = new HistoricItem(
            subject.name,
            subject.level,
            milestone.milestoneType,
            milestone.isApproved(),
            milestone.date);
        historicList.add(milestoneItem);
      }
    }
    historicList.sort((a, b) => a.date.compareTo(b.date));
    return historicList;
  }

  Widget _buildCareerHistory() {
    List careerHistoric = _buildCareerHistoric();
    List<TimelineModel> historicItems = List();
    historicItems.add(_buildWelcomeItem(HistoricItemCard.welcomeMessage()));
    for (HistoricItem historicItem in careerHistoric) {
      historicItems.add(_buildHistoricItem(historicItem));
    }
    return Timeline(children: historicItems, position: TimelinePosition.Left);
  }

  TimelineModel _buildHistoricItem(HistoricItem historicItem) {
    HistoricItemCard historicItemCard =
        new HistoricItemCard.createHistoricItem(historicItem);
    return TimelineModel(historicItemCard,
        position: TimelineItemPosition.left,
        iconBackground: Colors.white,
        icon:
            historicItem.isApproved ? Icon(Icons.done_all) : Icon(Icons.done));
  }
}

class HistoricItem {
  final String _subjectName;
  final int _level;
  final MilestoneType _milestoneType;
  final bool _isApproved;
  final DateTime _date;

  HistoricItem(this._subjectName, this._level, this._milestoneType,
      this._isApproved, this._date);

  String get subjectName => _subjectName;

  int get level => _level;

  MilestoneType get milestoneType => _milestoneType;

  bool get isApproved => _isApproved;

  DateTime get date => _date;
}
