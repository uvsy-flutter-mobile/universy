import 'package:universy/business/correlatives/validator.dart';
import 'package:universy/model/student/subject.dart';
import 'package:universy/model/subject.dart';

import 'command.dart';

class ApprovedOnNewCommand implements OnNewCommand {
  final Subject _subject;
  final Function() _updateTreeState;
  final CorrelativesValidator _correlativesValidator;

  const ApprovedOnNewCommand(
      {Subject subject,
      Function() updateTreeState,
      CorrelativesValidator correlativesValidator})
      : this._subject = subject,
        this._updateTreeState = updateTreeState,
        this._correlativesValidator = correlativesValidator;

  @override
  CorrelativeValidation checkCorrelative() {
    return _correlativesValidator.canApprove(_subject);
  }

  @override
  void perform(DateTime milestoneDate) {
    Milestone approvedMilestone =
        Milestone(MilestoneType.APPROVED, milestoneDate);
    _subject.milestones.add(approvedMilestone);
    _updateTreeState();
  }
}

class ApprovedOnUpdateCommand implements OnUpdateCommand {
  final Subject _subject;
  final Function() _updateTreeState;

  const ApprovedOnUpdateCommand({Subject subject, Function() updateTreeState})
      : this._subject = subject,
        this._updateTreeState = updateTreeState;

  @override
  void perform(DateTime milestoneDate) {
    _subject.getApprovedMilestone().ifPresent((m) => m.date = milestoneDate);
    _updateTreeState();
  }
}

class ApprovedOnDeleteCommand implements OnDeleteCommand {
  final Subject _subject;
  final Function() _updateTreeState;

  const ApprovedOnDeleteCommand({Subject subject, Function() updateTreeState})
      : this._subject = subject,
        this._updateTreeState = updateTreeState;

  @override
  void perform() {
    _subject.score = null;
    _subject.milestones.removeWhere((m) => m.isApproved());
    _updateTreeState();
  }
}
