import 'package:universy/business/subjects/classifier/classifier.dart';
import 'package:universy/business/subjects/classifier/state_classifier.dart';
import 'package:universy/model/subject.dart';
import 'package:universy/util/object.dart';

class SubjectCalculator {
  final List<Subject> _subjects;

  SubjectCalculator(this._subjects);

  double calculateAverage() {
    double average = 0.0;
    int subjectsLength = _amountOfScoredSubjects();

    if (subjectsLength != 0) {
      average = _subjects
              .map((m) => m.score)
              .where(notNull)
              .map((score) => score.toDouble())
              .reduce((a, b) => a + b) /
          subjectsLength;
    }
    return average;
  }

  int _amountOfScoredSubjects() {
    int subjectsLength = _subjects.map((m) => m.score).where(notNull).length;
    return subjectsLength;
  }

  double calculateProgress() {
    const double EMPTY_LIST_AVG = 0.0;
    if (_subjects.isNotEmpty) {
      int numberOfSubjects = _subjects.length;

      SubjectClassifier subjectClassifier = SubjectByStateClassifier();
      var classifierResult = subjectClassifier.classify(_subjects);

      int numberOfApprovedSubjects = classifierResult.approved.length;
      return numberOfApprovedSubjects / numberOfSubjects;
    } else {
      return EMPTY_LIST_AVG;
    }
  }

  int calculatePercentage() {
    return (calculateProgress() * 100).toInt();
  }

  bool isPendingToBegin() {
    SubjectClassifier subjectClassifier = SubjectByStateClassifier();
    var classifierResult = subjectClassifier.classify(_subjects);
    if (classifierResult.regular.isEmpty && classifierResult.approved.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  int getPoints() {
    int points = 0;
    int subjectsLength = _subjects.length;
    if (subjectsLength != 0) {
      points =
          _subjects.map((m) => m.points).where(notNull).reduce((a, b) => a + b);
    }
    return points;
  }

  int getHours() {
    int hours = 0;
    int subjectsLength = _subjects.length;
    if (subjectsLength != 0) {
      hours =
          _subjects.map((m) => m.hours).where(notNull).reduce((a, b) => a + b);
    }
    return hours;
  }
}
