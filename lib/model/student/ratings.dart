import 'package:universy/model/institution/ratings.dart';
import 'package:universy/model/json.dart';

class StudentCourseRating {
  String userId;
  String courseId;
  int overall;
  int difficulty;
  bool wouldTakeAgain;
  List<Tag> tags;
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
