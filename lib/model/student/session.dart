class Session {
  String _userId;
  String _deviceId;
  String _programId;

  Session(this._userId, this._deviceId, this._programId);

  String get programId => _programId;

  String get deviceId => _deviceId;

  String get userId => _userId;

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      json["userId"],
      json["deviceId"],
      json["programId"],
    );
  }
}
