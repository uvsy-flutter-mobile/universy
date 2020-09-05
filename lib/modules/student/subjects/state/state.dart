import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:universy/model/subject.dart';

import 'milestones/approved.dart';
import 'milestones/regular.dart';
import 'milestones/taking.dart';
import 'score.dart';

class SubjectStateWidget extends StatefulWidget {
  final Subject _subject;

  const SubjectStateWidget({Key key, @required Subject subject})
      : this._subject = subject,
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SubjectStateWidgetState();
  }
}

class SubjectStateWidgetState extends State<SubjectStateWidget> {
  static final DateFormat dateFormat = DateFormat("MMM yyyy");
  Subject _subject;

  @override
  void initState() {
    super.initState();
    this._subject = widget._subject;
  }

  @override
  void dispose() {
    super.dispose();
    this._subject = null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ScoreSubjectWidget(subject: _subject),
        ApprovedMilestoneWidget(
          subject: _subject,
          updateTreeState: updateState,
        ),
        RegularMilestoneWidget(subject: _subject, updateTreeState: updateState),
        TakingMilestoneWidget(subject: _subject, updateTreeState: updateState)
      ],
    );
  }

  void updateState() {
    setState(() {});
  }
}
