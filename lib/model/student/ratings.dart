import 'package:universy/model/copyable.dart';
import 'package:universy/model/json.dart';

class StudentCourseRating
    implements Copyable<StudentCourseRating>, JsonConvertible {
  String userId;
  String courseId;
  int overall;
  int difficulty;
  bool wouldTakeAgain;
  List<String> tags;

  StudentCourseRating.empty(this.courseId) : tags = List();

  StudentCourseRating(
    this.userId,
    this.courseId,
    this.overall,
    this.difficulty,
    this.wouldTakeAgain,
    this.tags,
  );

  void addTag(String tag) {
    this.tags.add(tag);
  }

  void removeTag(String tag) {
    this.tags.remove(tag);
  }

  @override
  StudentCourseRating copy() {
    return StudentCourseRating.fromJson(this.toJson());
  }

  factory StudentCourseRating.fromJson(Map<String, dynamic> json) {
    return StudentCourseRating(
      json["userId"],
      json["courseId"],
      json["overall"],
      json["difficulty"],
      json["wouldTakeAgain"],
      (json["tags"] as List).map((e) => e.toString()).toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "courseId": courseId,
      "overall": overall,
      "difficulty": difficulty,
      "wouldTakeAgain": wouldTakeAgain,
      "tags": tags,
    };
  }
}

class StudentSubjectRating implements JsonConvertible {
  String userId;
  String subjectId;
  int rating;

  StudentSubjectRating(this.userId, this.subjectId, this.rating);

  factory StudentSubjectRating.fromJson(Map<String, dynamic> json) {
    return StudentSubjectRating(
      json["userId"],
      json["subjectId"],
      json["rating"],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "subjectId": subjectId,
      "rating": rating,
    };
  }
}
