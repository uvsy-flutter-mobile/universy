import 'package:enum_to_string/enum_to_string.dart';

class InstitutionSubject {
  final String id;
  final String name;
  final String codename;
  final int level;
  final String programId;
  final int hours;
  final int points;
  final bool optative;
  final List<Correlative> correlatives;

  InstitutionSubject(
      this.id,
      this.name,
      this.codename,
      this.level,
      this.programId,
      this.hours,
      this.points,
      this.optative,
      this.correlatives);

  factory InstitutionSubject.fromJson(Map<String, dynamic> json) {
    List<Correlative> correlatives = (json['correlatives'] as List)
        .map((careerJson) => Correlative.fromJson(careerJson))
        .toList();

    return InstitutionSubject(
      json["id"],
      json["name"],
      json["codename"],
      json["level"],
      json["programId"],
      json["hours"],
      json["points"],
      json["optative"],
      correlatives,
    );
  }
}

class Correlative {
  final String id;
  final String correlativeSubjectId;
  final CorrelativeCondition correlativeCondition;
  final CorrelativeRestriction correlativeRestriction;

  Correlative(
    this.id,
    this.correlativeSubjectId,
    this.correlativeCondition,
    this.correlativeRestriction,
  );

  bool isToTake() {
    return correlativeRestriction == CorrelativeRestriction.TO_TAKE;
  }

  bool isToApprove() {
    return correlativeRestriction == CorrelativeRestriction.TO_APPROVE;
  }

  bool isApproveCondition() {
    return correlativeCondition == CorrelativeCondition.APPROVED;
  }

  bool isRegularCondition() {
    return correlativeCondition == CorrelativeCondition.REGULAR;
  }

  factory Correlative.fromJson(Map<String, dynamic> json) {
    var condition = EnumToString.fromString(
      CorrelativeCondition.values,
      json["correlativeCondition"],
    );
    var restriction = EnumToString.fromString(
      CorrelativeRestriction.values,
      json["correlativeRestriction"],
    );
    return Correlative(
      json["id"],
      json["correlativeSubjectId"],
      condition,
      restriction,
    );
  }
}

class CorrelativeItem {
  final String name;
  final int level;
  final CorrelativeCondition correlativeCondition;

  CorrelativeItem(
    this.name,
    this.level,
    this.correlativeCondition,
  );
}

enum CorrelativeCondition { APPROVED, REGULAR }

enum CorrelativeRestriction { TO_TAKE, TO_APPROVE }
