import 'package:universy/model/institution/commission.dart';
import 'package:universy/model/institution/course.dart';
import 'package:universy/model/institution/coursing_period.dart';
import 'package:universy/model/student/schedule.dart';
import 'package:universy/model/subject.dart';
import 'package:universy/util/object.dart';

class ScheduleScratchCourseListGenerator {
  final List<Subject> _subjects;
  final List<Commission> _commissions;
  final Course _course;

  ScheduleScratchCourseListGenerator(
      this._subjects, this._commissions, this._course);

  List<ScheduleScratchCourse> generate() {
    if (notNull(_course.periods) && _course.periods.length > 0) {
      Subject courseSubject = _subjects
          .firstWhere((Subject subject) => subject.id == _course.subjectId);
      Commission courseCommission = _commissions.firstWhere(
          (Commission commission) => commission.id == _course.commissionId);
      List<ScheduleScratchCourse> scheduleScratchCourses = [];

      _course.periods.forEach((CoursingPeriod coursingPeriod) {
        ScheduleScratchCourse newScheduleScratchCourse = ScheduleScratchCourse(
            _course.courseId,
            _course.subjectId,
            courseSubject.name,
            courseCommission,
            coursingPeriod);
        scheduleScratchCourses.add(newScheduleScratchCourse);
      });

      return scheduleScratchCourses;
    } else {
      return null;
    }
  }
}
