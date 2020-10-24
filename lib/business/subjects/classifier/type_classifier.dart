import 'package:universy/business/subjects/classifier/classifier.dart';
import 'package:universy/business/subjects/classifier/result.dart';
import 'package:universy/model/subject.dart';

class SubjectByTypeClassifier
    implements SubjectClassifier<SubjectByTypeResult> {
  @override
  SubjectByTypeResult classify(List<Subject> subjects) {
    _sortByLevel(subjects);
    List<Subject> optative = subjects.where((s) => s.isOptative()).toList();
    List<Subject> mandatory = subjects.where((s) => !s.isOptative()).toList();
    return SubjectByTypeResult(optative, mandatory);
  }

  void _sortByLevel(List<Subject> subjects) {
    subjects.sort((s1, s2) => s1.level.compareTo(s2.level));
  }
}
