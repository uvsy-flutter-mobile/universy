import "package:universy/model/institution/professor.dart";
import "package:universy/model/institution/schedule.dart";

class CoursingPeriod {
  final List<Schedule> _scheduleList;
  final List<Professor> _professors;
  final String _beginMonth;
  final String _endMonth;

  CoursingPeriod(
      this._scheduleList, this._professors, this._beginMonth, this._endMonth);

  String get endMonth => _endMonth;

  String get beginMonth => _beginMonth;

  List<Professor> get professors => _professors;

  List<Schedule> get scheduleList => _scheduleList;

  factory CoursingPeriod.fromJson(Map<String, dynamic> json) {
    List<Schedule> scheduleList = (json["schedules"] as List ?? [])
        .map((scheduleFromJson) => Schedule.fromJson(scheduleFromJson))
        .toList();
    List<Professor> professors = (json["professors"] as List ?? [])
        .map((professorFromJson) => Professor.fromJson(professorFromJson))
        .toList();
    return CoursingPeriod(
      scheduleList,
      professors,
      json["beginMonth"],
      json["endMonth"],
    );
  }
}
