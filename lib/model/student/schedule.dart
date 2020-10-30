import "package:collection/collection.dart";
import 'package:universy/constants/strings.dart';
import "package:universy/model/copyable.dart";
import 'package:universy/model/institution/commission.dart';
import 'package:universy/model/institution/coursing_period.dart';
import "package:universy/model/json.dart";

class StudentScheduleScratch
    implements JsonConvertible, Copyable<StudentScheduleScratch> {
  String scheduleScratchId;
  String name;
  int beginDate;
  int endDate;
  List<ScheduleScratchCourse> selectedCourses;
  DateTime updatedAt;
  DateTime createdAt;

  StudentScheduleScratch(this.scheduleScratchId, this.name, this.beginDate,
      this.endDate, this.selectedCourses, this.updatedAt, this.createdAt);

  // ignore: missing_return
  factory StudentScheduleScratch.fromJson(Map<String, dynamic> json) {
    //TODO: implement fromJson
  }

  factory StudentScheduleScratch.empty() {
    return StudentScheduleScratch(EMPTY_STRING, EMPTY_STRING, EMPTY_INT,
        EMPTY_INT, [], DateTime.now(), DateTime.now());
  }

  @override
  // ignore: missing_return
  Map<String, dynamic> toJson() {
    //TODO: implement toJson
  }

  @override
  StudentScheduleScratch copy() {
    return StudentScheduleScratch.fromJson(this.toJson());
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentScheduleScratch &&
          scheduleScratchId == other.scheduleScratchId &&
          name == other.name &&
          beginDate == other.beginDate &&
          endDate == other.endDate &&
          ListEquality().equals(selectedCourses, other.selectedCourses) &&
          updatedAt == other.updatedAt &&
          createdAt == other.createdAt;

  @override
  int get hashCode =>
      scheduleScratchId.hashCode ^
      name.hashCode ^
      beginDate.hashCode ^
      endDate.hashCode ^
      selectedCourses.hashCode ^
      updatedAt.hashCode ^
      createdAt.hashCode;
}

class ScheduleScratchCourse
    implements JsonConvertible, Copyable<ScheduleScratchCourse> {
  String courseId;
  String subjectId;
  String subjectName;
  Commission commission;
  CoursingPeriod period;

  ScheduleScratchCourse(this.courseId, this.subjectId, this.subjectName,
      this.commission, this.period);

  @override
  // ignore: missing_return
  Map<String, String> toJson() {
    //TODO: implement
  }

  // ignore: missing_return
  factory ScheduleScratchCourse.fromJson(Map<String, dynamic> json) {
    //TODO: implement
  }

  @override
  ScheduleScratchCourse copy() {
    return ScheduleScratchCourse.fromJson(this.toJson());
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScheduleScratchCourse &&
          courseId == other.courseId &&
          subjectId == other.subjectId &&
          subjectName == other.subjectName &&
          commission == other.commission &&
          period == other.period;

  @override
  int get hashCode =>
      courseId.hashCode ^
      subjectId.hashCode ^
      subjectName.hashCode ^
      commission.hashCode ^
      period.hashCode;
}
