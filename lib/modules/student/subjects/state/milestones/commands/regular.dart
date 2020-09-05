import 'package:universy/business/correlatives/validator.dart';
import 'package:universy/model/student/subject.dart';
import 'package:universy/model/subject.dart';

import 'command.dart';

class RegularOnNewCommand implements OnNewCommand {
  final Subject _subject;
  final Function() _updateTreeState;
  final CorrelativesValidator _correlativesValidator;

  const RegularOnNewCommand(
      {Subject subject,
      Function() updateTreeState,
      CorrelativesValidator correlativesValidator})
      : this._subject = subject,
        this._updateTreeState = updateTreeState,
        this._correlativesValidator = correlativesValidator;

  @override
  CorrelativeValidation checkCorrelative() {
    return _correlativesValidator.canRegularize(_subject);
  }

  @override
  void perform(DateTime milestoneDate) {
    Milestone regularMilestone =
        Milestone(MilestoneType.REGULAR, milestoneDate);
    _subject.milestones.add(regularMilestone);
    _updateTreeState();
  }
}

class RegularOnUpdateCommand implements OnUpdateCommand {
  final Subject _subject;
  final Function() _updateTreeState;

  const RegularOnUpdateCommand({Subject subject, Function() updateTreeState})
      : this._subject = subject,
        this._updateTreeState = updateTreeState;

  @override
  void perform(DateTime milestoneDate) {
    _subject.getRegularMilestone().ifPresent((m) => m.date = milestoneDate);
    _updateTreeState();
  }
}

class RegularOnDeleteCommand implements OnDeleteCommand {
  final Subject _subject;
  final Function() _updateTreeState;

  const RegularOnDeleteCommand({Subject subject, Function() updateTreeState})
      : this._subject = subject,
        this._updateTreeState = updateTreeState;

  @override
  void perform() {
    _subject.score = null;
    _subject.milestones.removeWhere((m) => m.isApproved() || m.isRegular());
    _updateTreeState();
  }
}
