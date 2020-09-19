import 'package:universy/model/institution/subject.dart';
import 'package:universy/model/student/subject.dart';
import 'package:universy/model/subject.dart';

class SubjectMatcher {
  List<Subject> apply(
    List<InstitutionSubject> institutionSubjects,
    List<StudentSubject> studentSubjects,
  ) {
    Map subjectIdMap = Map<String, StudentSubject>.fromIterable(
      studentSubjects,
      key: (subject) => subject.subjectId,
      value: (subject) => subject,
    );

    return institutionSubjects //
        .map((s) => Subject(s, subjectIdMap[s.id])) //
        .toList();
  }
}
