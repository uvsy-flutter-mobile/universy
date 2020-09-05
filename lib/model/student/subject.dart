import "package:collection/collection.dart";
import "package:enum_to_string/enum_to_string.dart";
import "package:intl/intl.dart";
import "package:universy/model/copyable.dart";
import "package:universy/model/json.dart";

class StudentSubject implements JsonConvertible, Copyable<StudentSubject> {
  String subjectId;
  int score;
  List<Milestone> milestones;

  StudentSubject({this.subjectId, this.score, this.milestones});

  factory StudentSubject.fromJson(Map<String, dynamic> json) {
    List<Milestone> milestoneList = (json["milestones"] as List) //
        .map((careerJson) => Milestone.fromJson(careerJson)) //
        .toList();

    return StudentSubject(
      subjectId: json["subjectId"],
      score: json["score"],
      milestones: milestoneList,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "subjectId": subjectId,
      "score": score,
      "milestones": milestones.map((m) => m.toJson()).toList(),
    };
  }

  @override
  StudentSubject copy() {
    return StudentSubject.fromJson(this.toJson());
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentSubject &&
          runtimeType == other.runtimeType &&
          subjectId == other.subjectId &&
          score == other.score &&
          ListEquality().equals(milestones, other.milestones);

  @override
  int get hashCode => subjectId.hashCode ^ score.hashCode ^ milestones.hashCode;
}

class Milestone implements JsonConvertible, Copyable<Milestone> {
  MilestoneType milestoneType;
  DateTime date;

  Milestone(this.milestoneType, this.date);

  @override
  Map<String, String> toJson() {
    DateFormat dateFormat = DateFormat("dd-MMM-yyyy");
    String type = EnumToString.parse(milestoneType);
    return {
      "milestoneType": type,
      "date": dateFormat.format(date),
    };
  }

  factory Milestone.fromJson(Map<String, dynamic> json) {
    DateFormat dateFormat = DateFormat("dd-MMM-yyyy");
    DateTime dateTime = dateFormat.parse(json["date"]);
    MilestoneType milestoneType = EnumToString.fromString(
      MilestoneType.values,
      json["milestoneType"],
    );
    return Milestone(milestoneType, dateTime);
  }

  bool isApproved() {
    return milestoneType == MilestoneType.APPROVED;
  }

  bool isRegular() {
    return milestoneType == MilestoneType.REGULAR;
  }

  bool isTaking() {
    return milestoneType == MilestoneType.TAKING;
  }

  @override
  Milestone copy() {
    return Milestone.fromJson(this.toJson());
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Milestone &&
          runtimeType == other.runtimeType &&
          milestoneType == other.milestoneType &&
          date == other.date;

  @override
  int get hashCode => milestoneType.hashCode ^ date.hashCode;
}

enum MilestoneType { APPROVED, REGULAR, TAKING, TO_TAKE }
