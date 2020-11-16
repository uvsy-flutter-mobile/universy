class Schedule {
  final String _dayOfWeek;
  final String _classroom;
  final int _beginTime;
  final int _endTime;

  Schedule(this._dayOfWeek, this._classroom, this._beginTime, this._endTime);

  String get dayOfWeek => _dayOfWeek;

  String get classroom => _classroom;

  int get beginTime => _beginTime;

  int get endTime => _endTime;

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      json["dayOfWeek"],
      json["classroom"],
      json["beginTime"],
      json["endTime"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "dayOfWeek": _dayOfWeek,
      "classroom": _classroom,
      "beginTime": _beginTime,
      "endTime": _endTime,
    };
  }
}
