import 'package:universy/business/correlatives/validator.dart';
import 'package:universy/model/student/subject.dart';
import 'package:universy/model/subject.dart';

import 'command.dart';

class TakingOnNewCommand implements OnNewCommand {
  final Subject _subject;
  final Function() _updateTreeState;
  final CorrelativesValidator _correlativesValidator;

  const TakingOnNewCommand(
      {Subject subject,
      Function() updateTreeState,
      CorrelativesValidator correlativesValidator})
      : this._subject = subject,
        this._updateTreeState = updateTreeState,
        this._correlativesValidator = correlativesValidator;

  @override
  CorrelativeValidation checkCorrelative() {
    return _correlativesValidator.canTake(_subject);
  }

  @override
  void perform(DateTime milestoneDate) {
    Milestone takingMilestone = Milestone(MilestoneType.TAKING, milestoneDate);
    StudentSubject studentSubject = StudentSubject(
      subjectId: _subject.id,
      milestones: [takingMilestone],
    );
    _subject.updateStudentSubject(studentSubject);
    _updateTreeState();
  }
}

class TakingOnUpdateCommand implements OnUpdateCommand {
  final Subject _subject;
  final Function() _updateTreeState;

  const TakingOnUpdateCommand({Subject subject, Function() updateTreeState})
      : this._subject = subject,
        this._updateTreeState = updateTreeState;

  @override
  void perform(DateTime milestoneDate) {
    _subject.getTakingMilestone().ifPresent((m) => m.date = milestoneDate);
    _updateTreeState();
  }
}

class TakingOnDeleteCommand implements OnDeleteCommand {
  final Subject _subject;
  final Function() _updateTreeState;

  const TakingOnDeleteCommand({Subject subject, Function() updateTreeState})
      : this._subject = subject,
        this._updateTreeState = updateTreeState;

  @override
  void perform() {
    _subject.score = null;
    _subject.clearMilestones();
    _updateTreeState();
  }
}
