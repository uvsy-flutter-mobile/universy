import 'package:universy/model/subject.dart';

import 'classifier.dart';
import 'result.dart';

class SubjectByYearClassifier
    implements SubjectClassifier<SubjectByYearResult> {
  @override
  SubjectByYearResult classify(List<Subject> subjects) {
    Map<int, List<Subject>> yearsWithSubjects = Map();

    for (Subject subject in subjects) {
      int year = subject.level;
      yearsWithSubjects.putIfAbsent(year, () => List());
      yearsWithSubjects[year].add(subject);
    }
    return SubjectByYearResult(yearsWithSubjects);
  }
}
