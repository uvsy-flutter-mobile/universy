class SubjectRating {
  String subjectId;
  Map<String, int> ratings;
}

class CourseRating {
  String courseId;
  Map<String, int> overall;
  Map<String, int> difficulty;
  int wouldTakeAgain;
  int wouldNotTakeAgain;
  List<TagRating> tagsRating;
}

class TagRating {
  Tag tag;
  int rating;
}

enum Tag {
  HARD_PRACTICAL,
  HARD_THEORETICAL,
  MANDATORY_CLASS,
  HARD_TO_UNDERSTAND,
  PROMOTIONABLE,
  DONT_GO_THERE,
  MIND_BLOWING,
  BE_READY_FOR_PW,
  TO_MUCH_EXTRA_TIME,
  SUMMARIES_AVAILABLE
}
