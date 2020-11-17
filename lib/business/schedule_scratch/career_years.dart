import 'package:universy/model/institution/subject.dart';

class ProgramYearsClassifier {
  List<int> yearsOfCareer(List<InstitutionSubject> subjects) {
    Map<int, List<InstitutionSubject>> yearsWithSubjects = Map();
    for (InstitutionSubject subject in subjects) {
      int year = subject.level;
      yearsWithSubjects.putIfAbsent(year, () => List());
      yearsWithSubjects[year].add(subject);
    }
    List<int> years = [];
    yearsWithSubjects.forEach((key, value) {
      years.add(key);
    });
    return years;
  }
}
