import 'package:universy/model/copyable.dart';
import 'package:universy/model/json.dart';

class InstitutionProgram
    implements Copyable<InstitutionProgram>, JsonConvertible {
  String _id;
  String _name;
  int _yearFrom;
  int _yearTo;
  int _hours;
  int _points;

  InstitutionProgram(
    this._id,
    this._name,
    this._yearFrom,
    this._yearTo,
    this._hours,
    this._points,
  );

  @override
  InstitutionProgram copy() {
    return InstitutionProgram.fromJson(this.toJson());
  }

  factory InstitutionProgram.fromJson(Map<String, dynamic> json) {
    return InstitutionProgram(
      json["id"],
      json["name"],
      json["yearFrom"],
      json["yearTo"],
      json["hours"],
      json["points"],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": _id,
      "name": _name,
      "yearFrom": _yearFrom,
      "yearTo": _yearTo,
      "hours": _hours,
      "points": _points,
    };
  }
}
