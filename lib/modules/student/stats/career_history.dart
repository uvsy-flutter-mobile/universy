import 'package:flutter/material.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';
import 'package:universy/model/student/subject.dart';
import 'package:universy/model/subject.dart';
import 'package:universy/modules/student/stats/career_history_card.dart';
import 'package:universy/text/text.dart';
import 'package:universy/util/object.dart';
import 'package:universy/widgets/paddings/edge.dart';

class CareerHistory extends StatefulWidget {
  final List<Subject> _subjects;

  const CareerHistory({Key key, List<Subject> subjects})
      : this._subjects = subjects,
        super(key: key);

  @override
  _CareerHistoryState createState() => _CareerHistoryState();
}

class _CareerHistoryState extends State<CareerHistory> {
  List<Subject> _subjects;
  String _selectedViewOption;
  List<String> _options = ["Todas", "Regulares", "Aprobadas"];
  List<HistoricItem> _historicList = [];

  @override
  void initState() {
    _subjects =
        widget._subjects.where((s) => s.isApproved() || s.isRegular()).toList();
    _selectedViewOption = "Todas";
    super.initState();
  }

  @override
  void dispose() {
    _subjects = null;
    _selectedViewOption = null;
    _historicList = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(child: _buildTitle(context), flex: 1),
        SizedBox(height: 10.0),
        Expanded(
          child: Container(width: 150.0, child: _buildDropDown()),
          flex: 2,
        ),
        Divider(
          color: Colors.grey,
          height: 2.0,
        ),
        SizedBox(height: 8.0),
        Expanded(child: _buildCareerHistory(), flex: 10)
      ],
    );
  }

  Widget _buildDropDown() {
    return (DropdownButtonFormField(
      decoration: InputDecoration(
        labelText: AppText.getInstance()
            .get("student.stats.view.careerHistory.LabelFilter"),
      ),
      onChanged: _onDropDownChange,
      isExpanded: true,
      value: _selectedViewOption,
      items: _options.map<DropdownMenuItem<String>>((String optionToView) {
        return DropdownMenuItem<String>(
          value: optionToView,
          child: Text(
            optionToView,
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList(),
    ));
  }

  void _onDropDownChange(String optionToView) {
    if (notNull(optionToView)) {
      switch (optionToView) {
        case "Todas":
          return _buildAllMilestones();
        case "Regulares":
          return _buildRegularMilestones();
        case "Aprobadas":
          return _buildApprovedMilestones();
        default:
          return null;
      }
    }
  }

  List _buildInitMilestones() {
    List milestones = [];
    List<HistoricItem> historic = [];
    for (Subject subject in _subjects) {
      milestones = subject.milestones
          .where((s) => s.isApproved() || s.isRegular())
          .toList();
      for (Milestone milestone in milestones) {
        HistoricItem milestoneItem = _buildHistoricItem(subject, milestone);
        historic.add(milestoneItem);
      }
    }
    return historic;
  }

  HistoricItem _buildHistoricItem(Subject subject, Milestone milestone) {
    return HistoricItem(subject.name, subject.level, milestone.milestoneType,
        milestone.isApproved(), milestone.date);
  }

  void _buildAllMilestones() {
    List milestones = [];
    List<HistoricItem> historic = [];
    for (Subject subject in _subjects) {
      milestones = subject.milestones
          .where((s) => s.isApproved() || s.isRegular())
          .toList();
      for (Milestone milestone in milestones) {
        HistoricItem milestoneItem = _buildHistoricItem(subject, milestone);
        historic.add(milestoneItem);
      }
    }
    setState(() {
      _historicList = historic;
    });
  }

  void _buildRegularMilestones() {
    List milestones = [];
    List<HistoricItem> historic = [];
    for (Subject subject in _subjects) {
      milestones = subject.milestones.where((s) => s.isRegular()).toList();
      for (Milestone milestone in milestones) {
        HistoricItem milestoneItem = _buildHistoricItem(subject, milestone);
        historic.add(milestoneItem);
      }
    }
    setState(() {
      _historicList = historic;
    });
  }

  void _buildApprovedMilestones() {
    List milestones = [];
    List<HistoricItem> historic = [];
    for (Subject subject in _subjects) {
      milestones = subject.milestones.where((s) => s.isApproved()).toList();
      for (Milestone milestone in milestones) {
        HistoricItem milestoneItem = _buildHistoricItem(subject, milestone);
        historic.add(milestoneItem);
      }
    }
    setState(() {
      _historicList = historic;
    });
  }

  Widget _buildTitle(BuildContext context) {
    return OnlyEdgePaddedWidget.top(
      padding: 20.0,
      child: Text(
          AppText.getInstance().get("student.stats.view.careerHistory.title"),
          textAlign: TextAlign.center,
          style: Theme.of(context).primaryTextTheme.headline4,
          overflow: TextOverflow.clip),
    );
  }

  TimelineModel _buildWelcomeItem(Widget historicItem) {
    return TimelineModel(historicItem,
        position: TimelineItemPosition.left,
        iconBackground: Colors.white,
        icon: Icon(Icons.flag));
  }

  List<HistoricItem> _buildCareerHistoric() {
    if (isNull(_historicList) || _historicList.isEmpty) {
      _historicList = _buildInitMilestones();
    }
    _historicList.sort((a, b) => a.date.compareTo(b.date));
    return _historicList;
  }

  Widget _buildCareerHistory() {
    List careerHistoric = _buildCareerHistoric();
    List<TimelineModel> historicItems = List();
    historicItems.add(_buildWelcomeItem(HistoricItemCard.welcomeMessage()));
    for (HistoricItem historicItem in careerHistoric) {
      historicItems.add(_buildHistoricTimelineModel(historicItem));
    }
    return Timeline(children: historicItems, position: TimelinePosition.Left);
  }

  TimelineModel _buildHistoricTimelineModel(HistoricItem historicItem) {
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
