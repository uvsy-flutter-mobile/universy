import 'package:universy/model/institution/ratings.dart';

class StudentCourseRating {
  String userId;
  String courseId;
  int overall;
  int difficulty;
  bool wouldTakeAgain;
  List<Tag> tags;
}

class StudentSubjectRating {
  String userId;
  String subjectId;
  int rating;
}
