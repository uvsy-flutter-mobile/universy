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
  final String userId;
  final String programId;
  final String scratchName;
  final int beginDate;
  final int endDate;
  final List<ScheduleScratchCourse> selectedCourses;

  CreateScratchPayload(this.userId, this.programId, this.scratchName,
      this.beginDate, this.endDate, this.selectedCourses);

  @override
  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "programId": programId,
      "name": scratchName,
      "beginDate": beginDate,
      "endDate": endDate,
      "selectedCourses": selectedCourses.isEmpty
          ? []
          : selectedCourses.map((e) => e.toJson()).toList(),
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
      "beginDate": begin,
      "endDate": end,
      "selectedCourses": studentScheduleScratch.selectedCourses
          .map((e) => e.toJson())
          .toList(),
    };
  }
}
