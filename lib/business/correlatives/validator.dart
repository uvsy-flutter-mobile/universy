import 'package:optional/optional.dart';
import 'package:universy/model/institution/subject.dart';
import 'package:universy/model/subject.dart';

class CorrelativesValidator {
  final Map<String, Subject> subjectIdMap;

  CorrelativesValidator(this.subjectIdMap);

  factory CorrelativesValidator.fromSubjects(List<Subject> subjects) {
    Map subjectIdMap = Map<String, Subject>.fromIterable(
      subjects,
      key: (subject) => subject.id,
      value: (subject) => subject,
    );

    return CorrelativesValidator(subjectIdMap);
  }

  CorrelativeValidation canApprove(Subject subject) {
    var correlatives = subject.correlatives;
    List<CorrelativeCheck> correlativeCheckList = List();

    for (Correlative correlative in correlatives) {
      if (correlative.isToApprove()) {
        var correlativeSubject = subjectIdMap[correlative.subjectId];

        if (correlative.isApproveCondition()) {
          correlativeCheckList.add(CorrelativeCheck(correlativeSubject,
              correlativeSubject.isApproved(), CorrelativeCondition.APPROVED));
        } else if (correlative.isRegularCondition()) {
          correlativeCheckList.add(CorrelativeCheck(
              correlativeSubject,
              correlativeSubject.hasRegularMilestone,
              CorrelativeCondition.REGULAR));
        }
      }
    }

    return CorrelativeValidation(correlativeCheckList);
  }

  CorrelativeValidation canRegularize(Subject subject) {
    return CorrelativeValidation.valid();
  }

  CorrelativeValidation canTake(Subject subject) {
    var correlatives = subject.correlatives;
    List<CorrelativeCheck> correlativeCheckList = List();

    for (Correlative correlative in correlatives) {
      if (correlative.isToTake()) {
        var correlativeSubject = subjectIdMap[correlative.subjectId];

        if (correlative.isApproveCondition()) {
          correlativeCheckList.add(CorrelativeCheck(correlativeSubject,
              correlativeSubject.isApproved(), CorrelativeCondition.APPROVED));
        } else if (correlative.isRegularCondition()) {
          correlativeCheckList.add(CorrelativeCheck(
              correlativeSubject,
              correlativeSubject.hasRegularMilestone,
              CorrelativeCondition.REGULAR));
        }
      }
    }
    return CorrelativeValidation(correlativeCheckList);
  }
}

class CorrelativeValidation {
  final List<CorrelativeCheck> correlatives;

  CorrelativeValidation(this.correlatives);

  CorrelativeValidation.valid() : this.correlatives = List();

  bool get isValid {
    return Optional.ofNullable(correlatives)
        .orElse(List())
        .where((correlativeCheck) => correlativeCheck.isNotValid)
        .isEmpty;
  }

  bool get isNotValid => !isValid;
}

class CorrelativeCheck {
  final Subject subject;
  final bool isValid;
  final CorrelativeCondition condition;

  CorrelativeCheck(this.subject, this.isValid, this.condition);

  bool get isNotValid => !isValid;
}
