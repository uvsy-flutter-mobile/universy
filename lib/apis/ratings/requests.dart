import 'package:universy/model/json.dart';

class StudentSubjectRatingPayload extends JsonConvertible {
  final int rating;

  StudentSubjectRatingPayload(this.rating);

  @override
  Map<String, dynamic> toJson() {
    return {
      "rating": rating,
    };
  }
}

class StudentCourseRatingPayload extends JsonConvertible {
  final int overall;
  final int difficulty;
  final bool wouldTakeAgain;
  final List<String> tags;

  StudentCourseRatingPayload(
      this.overall, this.difficulty, this.wouldTakeAgain, this.tags);

  @override
  Map<String, dynamic> toJson() {
    return {
      "overall": overall,
      "difficulty": difficulty,
      "wouldTakeAgain": wouldTakeAgain,
      "tags": tags,
    };
  }
}
