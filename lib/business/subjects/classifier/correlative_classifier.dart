import 'package:universy/model/institution/subject.dart';

class SubjectCorrelativeClassifier {
  InstitutionSubjectCorrelativeResult classify(
      InstitutionSubject institutionSubject) {
    var correlativeList = institutionSubject.correlatives;

    var correlativesToTake = correlativeList
        .where(
          (correlative) => correlative.isToTake(),
        )
        .toList();

    var correlativesToApprove = correlativeList
        .where(
          (correlative) => correlative.isToApprove(),
        )
        .toList();

    return InstitutionSubjectCorrelativeResult(
      correlativesToApprove,
      correlativesToTake,
    );
  }
}

class InstitutionSubjectCorrelativeResult {
  final List<Correlative> correlativesToTake;
  final List<Correlative> correlativesToApprove;

  InstitutionSubjectCorrelativeResult(
      this.correlativesToApprove, this.correlativesToTake);
}
