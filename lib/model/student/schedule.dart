import 'dart:js';
import 'dart:ui';

import "package:collection/collection.dart";
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universy/constants/strings.dart';
import "package:universy/model/copyable.dart";
import 'package:universy/model/institution/commission.dart';
import 'package:universy/model/institution/course.dart';
import 'package:universy/model/institution/coursing_period.dart';
import 'package:universy/model/institution/subject.dart';
import "package:universy/model/json.dart";
import 'package:universy/model/subject.dart';
import 'package:universy/services/factory.dart';
import 'package:universy/services/impl/institution/institution.dart';
import 'package:universy/services/impl/student/account.dart';
import 'package:universy/services/impl/student/career.dart';

class StudentScheduleScratch
    implements JsonConvertible, Copyable<StudentScheduleScratch> {
  String scheduleScratchId;
  String name;
  DateTime beginDate;
  DateTime endDate;
  List<ScheduleScratchCourse> selectedCourses;
  DateTime updatedAt;
  DateTime createdAt;

  StudentScheduleScratch(this.scheduleScratchId, this.name, this.beginDate,
      this.endDate, this.selectedCourses, this.updatedAt, this.createdAt);

  factory StudentScheduleScratch.empty() {
    return StudentScheduleScratch(EMPTY_STRING, EMPTY_STRING, DateTime.now(),
        DateTime.now(), [], DateTime.now(), DateTime.now());
  }

  factory StudentScheduleScratch.fromJson(Map<String, dynamic> json) {
    List<ScheduleScratchCourse> courses = (json["selectedCourses"] as List) //
        .map((courseJson) => ScheduleScratchCourse.fromJson(courseJson)) //
        .toList();
    var updatedAt = DateTime.fromMillisecondsSinceEpoch(json["updatedAt"]);
    var createdAt = DateTime.fromMillisecondsSinceEpoch(json["createdAt"]);
    var beginDate = DateTime.fromMillisecondsSinceEpoch(json["beginDate"]);
    var endDate = DateTime.fromMillisecondsSinceEpoch(json["endDate"]);

    return StudentScheduleScratch(
      json["scheduleScratchId"],
      json["name"],
      beginDate,
      endDate,
      courses,
      updatedAt,
      createdAt,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "beginTime": beginDate,
      "endTime": endDate,
      "selectedCourses": selectedCourses.map((e) => e.toJson()).toList(),
    };
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
  Color color;

  ScheduleScratchCourse(this.courseId, this.subjectId, this.subjectName,
      this.commission, this.period, this.color);

  // ignore: missing_return
  factory ScheduleScratchCourse.fromJson(Map<String, dynamic> json) {
    Color colorToCourse = json["color"];
    CoursingPeriod coursingPeriod = CoursingPeriod.fromJson(json);
    Commission commission = new Commission.empty(json["commisionId"]);

    return ScheduleScratchCourse(
      json["courseId"],
      json["subjectId"],
      EMPTY_STRING,
      commission,
      coursingPeriod,
      colorToCourse,
    );
  }

  @override
  ScheduleScratchCourse copy() {
    return ScheduleScratchCourse.fromJson(this.toJson());
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "courseId": courseId,
      "subjectId": subjectId,
      "subjectName": subjectName,
      "comissionId": commission.id,
      "color": color.toString(),
      "coursingPeriod": period.toJson(),
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScheduleScratchCourse &&
          courseId == other.courseId &&
          subjectId == other.subjectId &&
          subjectName == other.subjectName &&
          commission == other.commission &&
          period == other.period &&
          color == other.color;

  @override
  int get hashCode =>
      courseId.hashCode ^
      subjectId.hashCode ^
      subjectName.hashCode ^
      commission.hashCode ^
      period.hashCode;
}
