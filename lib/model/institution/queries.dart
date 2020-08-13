import 'career.dart';
import 'institution.dart';

class InstitutionProgramInfo {
  String _programId;
  Institution _institution;
  InstitutionCareer _career;

  InstitutionProgramInfo(this._programId, this._institution, this._career);

  String get programId => _programId;

  Institution get institution => _institution;

  InstitutionCareer get career => _career;

  factory InstitutionProgramInfo.fromJson(Map<String, dynamic> json) {
    var institution = Institution.fromJson(json["institution"]);
    var career = InstitutionCareer.fromJson(json["career"]);
    return InstitutionProgramInfo(
      json["programId"],
      institution,
      career,
    );
  }
}
