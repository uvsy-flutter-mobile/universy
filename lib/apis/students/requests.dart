import 'package:universy/model/json.dart';
import 'package:universy/model/student/subject.dart';

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

// Notes

class CreateNoteRequest extends JsonConvertible {
  final String title;
  final String description;

  CreateNoteRequest(this.title, this.description);

  @override
  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
    };
  }
}

class UpdateNoteRequest extends JsonConvertible {
  final String title;
  final String description;

  UpdateNoteRequest(this.title, this.description);

  @override
  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
    };
  }
}

// Career
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

// Subjects
class UpdateSubjectPayload extends JsonConvertible {
  final String programId;
  final int score;
  final List<Milestone> milestones;

  UpdateSubjectPayload(this.programId, this.score, this.milestones);

  @override
  Map<String, dynamic> toJson() {
    return {
      "programId": programId,
      "score": score,
      "milestones": milestones.map((e) => e.toJson()).toList(),
    };
  }
}
