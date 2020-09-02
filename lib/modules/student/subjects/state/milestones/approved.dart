import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:optional/optional_internal.dart';
import 'package:provider/provider.dart';
import 'package:universy/business/correlatives/validator.dart';
import 'package:universy/model/student/subject.dart';
import 'package:universy/model/subject.dart';
import 'package:universy/model/time.dart';
import 'package:universy/system/locale.dart';

import 'cards/existing.dart';
import 'cards/new.dart';
import 'commands/approved.dart';

class ApprovedMilestoneWidget extends StatelessWidget {
  static final DateFormat dateFormat =
      DateFormat("MMM yyyy", SystemLocale.getSystemLocale().toString());
  final Subject _subject;
  final Function() updateTreeState;

  const ApprovedMilestoneWidget(
      {Key key,
      @required Subject subject,
      @required Function() updateTreeState})
      : this._subject = subject,
        this.updateTreeState = updateTreeState,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime from =
        _subject.getRegularMilestone().map((m) => m.date).orElse(null);
    DateTimeRange dateTimeRange = DateTimeRange.noEnd(from);
    CorrelativesValidator correlativesValidator =
        Provider.of<CorrelativesValidator>(context);
    var approvedMilestone = _subject.getApprovedMilestone();
    return _buildMilestone(
        milestone: approvedMilestone,
        isAvailable: _subject.isRegular(),
        dateTimeRange: dateTimeRange,
        correlativesValidator: correlativesValidator);
  }

  Widget _buildMilestone(
      {Optional<Milestone> milestone,
      bool isAvailable = true,
      DateTimeRange dateTimeRange,
      CorrelativesValidator correlativesValidator}) {
    if (milestone.isPresent) {
      return ExistingMilestoneWidget(
        milestone: milestone.value,
        onDeleteCommand: ApprovedOnDeleteCommand(
            subject: _subject, updateTreeState: updateTreeState),
        onUpdateCommand: ApprovedOnUpdateCommand(
            subject: _subject, updateTreeState: updateTreeState),
        dateTimeRange: dateTimeRange,
      );
    } else {
      return NewMilestoneWidget(
        // TODO: Apptext
        milestoneDisplayName: "Aprobar",
        available: isAvailable,
        onNewCommand: ApprovedOnNewCommand(
          subject: _subject,
          updateTreeState: updateTreeState,
          correlativesValidator: correlativesValidator,
        ),
        dateTimeRange: dateTimeRange,
      );
    }
  }
}
