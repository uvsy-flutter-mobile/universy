import 'package:universy/model/copyable.dart';
import 'package:universy/model/json.dart';

class StudentCareer implements JsonConvertible, Copyable<StudentCareer> {
  String _userId;
  String _programId;
  int _beginYear;
  int _endYear;

  StudentCareer(this._userId, this._programId, this._beginYear, this._endYear);

  String get userId => _userId;

  String get programId => _programId;

  int get beginYear => _beginYear;

  int get endYear => _endYear;

  factory StudentCareer.fromJson(Map<String, dynamic> json) {
    return StudentCareer(
      json["userId"],
      json["programId"],
      json["beginYear"],
      json["endYear"],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "userId": _userId,
      "programId": _programId,
      "beginYear": _beginYear,
      "endYear": _endYear,
    };
  }

  @override
  StudentCareer copy() {
    return StudentCareer.fromJson(this.toJson());
  }
}
