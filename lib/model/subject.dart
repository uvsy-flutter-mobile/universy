import 'dart:core';

import 'package:optional/optional.dart';
import 'package:universy/model/student/subject.dart';
import 'package:universy/util/object.dart';

import 'copyable.dart';
import 'institution/subject.dart';

class Subject implements Copyable<Subject> {
  InstitutionSubject _institutionSubject;
  StudentSubject _studentSubject;

  Subject(this._institutionSubject, this._studentSubject);

  Subject.incomplete(InstitutionSubject institutionSubject)
      : this._institutionSubject = institutionSubject,
        this._studentSubject = null;

  String get programId => _institutionSubject.programId;

  String get id => _institutionSubject.id;

  String get name => _institutionSubject.name;

  int get level => _institutionSubject.level;

  List<Correlative> get correlatives => _institutionSubject.correlatives;

  List<Milestone> get milestones => _studentSubject?.milestones;

  int get score => _studentSubject?.score;

  bool get optative => _institutionSubject.optative;

  int get points => _institutionSubject.points;

  int get hours => _institutionSubject.hours;

  set score(int score) => _studentSubject.score = score;

  StudentSubject get studentSubject => _studentSubject;

  InstitutionSubject get institutionSubject => _institutionSubject;

  bool isApproved() {
    if (notNull(_studentSubject)) {
      return getApprovedMilestone().isPresent;
    }
    return false;
  }

  bool isRegular() {
    if (notNull(_studentSubject)) {
      List<Milestone> milestones = _studentSubject.milestones;
      return !isApproved() &&
          notNull(milestones.firstWhere((milestone) => milestone.isRegular(),
              orElse: () => null));
    }
    return false;
  }

  bool isTaking() {
    if (notNull(_studentSubject)) {
      return !isApproved() && !isRegular() && getTakingMilestone().isPresent;
    }
    return false;
  }

  bool isToTake() {
    if (notNull(_studentSubject)) {
      return _studentSubject.milestones.isEmpty;
    }
    return true;
  }

  bool isOptative() {
    if (notNull(optative)) {
      return optative;
    }
    return false;
  }

  Optional<Milestone> getTakingMilestone() {
    return Optional.ofNullable(milestones
        ?.firstWhere((milestone) => milestone.isTaking(), orElse: () => null));
  }

  Optional<Milestone> getRegularMilestone() {
    return Optional.ofNullable(milestones
        ?.firstWhere((milestone) => milestone.isRegular(), orElse: () => null));
  }

  Optional<Milestone> getApprovedMilestone() {
    return Optional.ofNullable(milestones?.firstWhere(
        (milestone) => milestone.isApproved(),
        orElse: () => null));
  }

  bool get hasTakingMilestone => getTakingMilestone().isPresent;

  bool get hasRegularMilestone => getRegularMilestone().isPresent;

  bool get hasApproveMilestone => getRegularMilestone().isPresent;

  bool updateStudentSubject(StudentSubject updateStudentSubject) {
    if (notNull(updateStudentSubject)) {
      if (isNull(_studentSubject)) {
        _studentSubject = updateStudentSubject.copy();
      } else {
        _studentSubject.score = updateStudentSubject.score;
        _studentSubject.milestones = updateStudentSubject.milestones
            .map((milestone) => milestone.copy())
            .toList();
      }
      return true;
    }
    return false;
  }

  void clearMilestones() {
    Optional.ofNullable(_studentSubject)
        .map((subject) => subject.milestones)
        .ifPresent((milestones) => milestones.clear());
  }

  @override
  Subject copy() {
    return Subject(
      _institutionSubject,
      _studentSubject?.copy(),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Subject &&
          runtimeType == other.runtimeType &&
          _studentSubject == other._studentSubject;

  @override
  int get hashCode => _studentSubject.hashCode;
}
