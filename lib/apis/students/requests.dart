import 'package:universy/model/json.dart';

class UpdateProfileRequest extends JsonConvertible {
  final String name;
  final String lastName;
  final String alias;

  UpdateProfileRequest(this.name, this.lastName, this.alias);

  @override
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "lastName": lastName,
      "alias": alias,
    };
  }
}

// Student Career
class CreateCareerRequest extends JsonConvertible {
  final String programId;
  final int beginYear;
  final int endYear;

  CreateCareerRequest(this.programId, this.beginYear, this.endYear);

  @override
  Map<String, dynamic> toJson() {
    return {
      "programId": programId,
      "beginYear": beginYear,
      "endYear": endYear,
    };
  }
}
