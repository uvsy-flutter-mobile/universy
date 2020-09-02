import 'package:flutter/material.dart';
import 'package:optional/optional_internal.dart';
import 'package:provider/provider.dart';
import 'package:universy/business/correlatives/validator.dart';
import 'package:universy/model/student/subject.dart';
import 'package:universy/model/subject.dart';
import 'package:universy/model/time.dart';

import 'cards/existing.dart';
import 'cards/new.dart';
import 'commands/regular.dart';

class RegularMilestoneWidget extends StatelessWidget {
  final Subject _subject;
  final Function() updateTreeState;

  const RegularMilestoneWidget(
      {Key key,
      @required Subject subject,
      @required Function() updateTreeState})
      : this._subject = subject,
        this.updateTreeState = updateTreeState,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var regularMilestone = _subject.getRegularMilestone();
    DateTime from =
        _subject.getTakingMilestone().map((m) => m.date).orElse(null);
    DateTime to =
        _subject.getApprovedMilestone().map((m) => m.date).orElse(null);
    DateTimeRange dateTimeRange = DateTimeRange(from, to);
    CorrelativesValidator correlativesValidator =
        Provider.of<CorrelativesValidator>(context);
    return _buildMilestone(
        milestone: regularMilestone,
        isAvailable: _subject.isTaking(),
        dateTimeRange: dateTimeRange,
        correlativesValidator: correlativesValidator);
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
        onDeleteCommand: RegularOnDeleteCommand(
            subject: _subject, updateTreeState: updateTreeState),
        onUpdateCommand: RegularOnUpdateCommand(
            subject: _subject, updateTreeState: updateTreeState),
        dateTimeRange: dateTimeRange,
      );
    } else {
      return NewMilestoneWidget(
        // TODO: Apptext
        milestoneDisplayName: "Regularizar",
        available: isAvailable,
        onNewCommand: RegularOnNewCommand(
          subject: _subject,
          updateTreeState: updateTreeState,
          correlativesValidator: correlativesValidator,
        ),
        dateTimeRange: dateTimeRange,
      );
    }
  }
}
