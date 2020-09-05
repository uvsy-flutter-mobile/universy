import 'package:universy/model/subject.dart';

import 'classifier.dart';
import 'result.dart';

class SubjectByStateClassifier
    implements SubjectClassifier<SubjectByStateResult> {
  @override
  SubjectByStateResult classify(List<Subject> subjects) {
    _sortByLevel(subjects);
    List<Subject> toTake = subjects.where((s) => s.isToTake()).toList();
    List<Subject> taking = subjects.where((s) => s.isTaking()).toList();
    List<Subject> regular = subjects.where((s) => s.isRegular()).toList();
    List<Subject> approved = subjects.where((s) => s.isApproved()).toList();
    return SubjectByStateResult(toTake, taking, regular, approved);
  }

  void _sortByLevel(List<Subject> subjects) {
    subjects.sort((s1, s2) => s1.level.compareTo(s2.level));
  }
}
