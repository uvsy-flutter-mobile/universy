import "coursing_period.dart";

class Course {
  final String _courseId;
  final String _subjectId;
  final String _commissionId;
  final List<CoursingPeriod> _periods;

  Course(this._courseId, this._commissionId, this._subjectId, this._periods);

  String get courseId => _courseId;

  String get subjectId => _subjectId;

  String get commissionId => _commissionId;

  List<CoursingPeriod> get periods => _periods;

  factory Course.fromJson(Map<String, dynamic> json) {
    List<CoursingPeriod> periodList = (json["periods"] as List ?? [])
        .map((periodJson) => CoursingPeriod.fromJson(periodJson))
        .toList();
    return Course(
      json["courseId"],
      json["commissionId"],
      json["subjectId"],
      periodList,
    );
  }

  @override
  int get hashCode => courseId.hashCode;

  @override
  bool operator ==(dynamic other) => courseId == other?.courseId;
}

class Commission {
  final String id;
  final String name;
  final String programId;
  final int level;

  Commission._(this.id, this.name, this.programId, this.level);

  factory Commission.fromJson(Map<String, dynamic> json) {
    return Commission._(
      json["id"],
      json["name"],
      json["programId"],
      json["level"],
    );
  }
}
