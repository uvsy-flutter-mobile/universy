import 'dart:math';

import 'package:universy/model/subject.dart';

class SubjectByStateResult {
  final List<Subject> toTake;
  final List<Subject> taking;
  final List<Subject> regular;
  final List<Subject> approved;

  SubjectByStateResult(
    this.toTake,
    this.taking,
    this.regular,
    this.approved,
  );
}

class SubjectByYearResult {
  final Map<int, List<Subject>> yearsWithSubjects;

  SubjectByYearResult(this.yearsWithSubjects);

  List<Subject> getSubjects(int year) {
    return yearsWithSubjects[year] ?? [];
  }

  int numberOfYears() {
    return yearsWithSubjects.keys.reduce(max);
  }
}

class SubjectByTypeResult {
  final List<Subject> optative;
  final List<Subject> mandatory;

  SubjectByTypeResult(
    this.optative,
    this.mandatory,
  );
}
