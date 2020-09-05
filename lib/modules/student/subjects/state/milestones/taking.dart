import 'package:flutter/material.dart';
import 'package:optional/optional_internal.dart';
import 'package:provider/provider.dart';
import 'package:universy/business/correlatives/validator.dart';
import 'package:universy/model/student/subject.dart';
import 'package:universy/model/subject.dart';
import 'package:universy/model/time.dart';
import 'package:universy/text/text.dart';

import 'cards/existing.dart';
import 'cards/new.dart';
import 'commands/taking.dart';

class TakingMilestoneWidget extends StatelessWidget {
  final Subject _subject;
  final Function() updateTreeState;

  const TakingMilestoneWidget(
      {Key key,
      @required Subject subject,
      @required Function() updateTreeState})
      : this._subject = subject,
        this.updateTreeState = updateTreeState,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var takingMilestone = _subject.getTakingMilestone();
    DateTime to =
        _subject.getRegularMilestone().map((m) => m.date).orElse(null);
    DateTimeRange dateTimeRange = DateTimeRange.noBegin(to);
    CorrelativesValidator correlativesValidator =
        Provider.of<CorrelativesValidator>(context);
    return _buildMilestone(
      milestone: takingMilestone,
      dateTimeRange: dateTimeRange,
      correlativesValidator: correlativesValidator,
    );
  }

  Widget _buildMilestone(
      {Optional<Milestone> milestone,
      bool isAvailable = true,
      Function(DateTime milestoneDate) onOk,
      VoidCallback onDelete,
      Function(DateTime milestoneDate) onNew,
      DateTimeRange dateTimeRange,
      CorrelativesValidator correlativesValidator}) {
    if (milestone.isPresent) {
      return ExistingMilestoneWidget(
        milestone: milestone.value,
        onDeleteCommand: TakingOnDeleteCommand(
          subject: _subject,
          updateTreeState: updateTreeState,
        ),
        onUpdateCommand: TakingOnUpdateCommand(
          subject: _subject,
          updateTreeState: updateTreeState,
        ),
        dateTimeRange: dateTimeRange,
      );
    } else {
      return NewMilestoneWidget(
        milestoneDisplayName:
            AppText.getInstance().get("student.subjects.states.actions.take"),
        available: isAvailable,
        onNewCommand: TakingOnNewCommand(
          subject: _subject,
          updateTreeState: updateTreeState,
          correlativesValidator: correlativesValidator,
        ),
        dateTimeRange: dateTimeRange,
      );
    }
  }
}
