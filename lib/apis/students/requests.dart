import 'package:universy/model/json.dart';
import 'package:universy/model/student/schedule.dart';
import 'package:universy/model/student/subject.dart';
import 'package:universy/modules/student/schedule/bloc/states.dart';

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

// Schedule Scratches

class CreateScratchPayload extends JsonConvertible {
  final StudentScheduleScratch studentScheduleScratch;
  final String userId;
  final String programId;

  CreateScratchPayload(
      this.studentScheduleScratch, this.userId, this.programId);

  @override
  Map<String, dynamic> toJson() {
    int begin = studentScheduleScratch.beginDate.millisecondsSinceEpoch;
    int end = studentScheduleScratch.endDate.millisecondsSinceEpoch;
    return {
      "userId": userId,
      "programId": programId,
      "name": studentScheduleScratch.name,
      "beginTime": begin,
      "endTime": end,
      "selectedCourses": studentScheduleScratch.selectedCourses
          .map((e) => e.toJson())
          .toList(),
    };
  }
}

class UpdateScratchPayload extends JsonConvertible {
  final StudentScheduleScratch studentScheduleScratch;

  UpdateScratchPayload(this.studentScheduleScratch);

  @override
  Map<String, dynamic> toJson() {
    int begin = studentScheduleScratch.beginDate.millisecondsSinceEpoch;
    int end = studentScheduleScratch.endDate.millisecondsSinceEpoch;

    return {
      "name": studentScheduleScratch.name,
      "beginTime": begin,
      "endTime": end,
      "selectedCourses": studentScheduleScratch.selectedCourses
          .map((e) => e.toJson())
          .toList(),
    };
  }
}
