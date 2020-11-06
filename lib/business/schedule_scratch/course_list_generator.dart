import 'package:universy/model/institution/commission.dart';
import 'package:universy/model/institution/course.dart';
import 'package:universy/model/institution/coursing_period.dart';
import 'package:universy/model/institution/subject.dart';
import 'package:universy/model/student/schedule.dart';
import 'package:universy/util/object.dart';

class ScheduleScratchCourseListGenerator {
  final List<InstitutionSubject> _subjects;
  final List<Commission> _commissions;
  final Course _course;

  ScheduleScratchCourseListGenerator(
      this._subjects, this._commissions, this._course);

  List<ScheduleScratchCourse> generate() {
    if (notNull(_course.periods) && _course.periods.length > 0) {
      InstitutionSubject courseSubject = _subjects.firstWhere(
          (InstitutionSubject subject) => subject.id == _course.subjectId,
          orElse: null);
      Commission courseCommission = _commissions.firstWhere(
          (Commission commission) => commission.id == _course.commissionId,
          orElse: null);
      List<ScheduleScratchCourse> scheduleScratchCourses = [];

      _course.periods.forEach((CoursingPeriod coursingPeriod) {
        ScheduleScratchCourse newScheduleScratchCourse = ScheduleScratchCourse(
          _course.courseId,
          _course.subjectId,
          courseSubject.name,
          courseCommission,
          coursingPeriod,
          null,
        );
        scheduleScratchCourses.add(newScheduleScratchCourse);
      });

      return scheduleScratchCourses;
    } else {
      return null;
    }
  }
}
