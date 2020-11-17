class Schedule {
  final String _dayOfWeek;
  final int _beginTime;
  final int _endTime;
  final String _classroom;

  Schedule(
    this._dayOfWeek,
    this._beginTime,
    this._endTime,
    this._classroom,
  );

  String get dayOfWeek => _dayOfWeek;

  String get classroom => _classroom;

  int get beginTime => _beginTime;

  int get endTime => _endTime;

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      json["dayOfWeek"],
      json["beginTime"],
      json["endTime"],
      json["classroom"],
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

  Map<String, dynamic> scheduleToJson() {
    return {
      "dayOfWeek": _dayOfWeek,
      "beginTime": _beginTime,
      "endTime": _endTime,
      "classroom": _classroom,
    };
  }
}
