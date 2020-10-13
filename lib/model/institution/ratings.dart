class SubjectRating {
  final String subjectId;
  final Map<String, dynamic> ratings;

  SubjectRating._(this.subjectId, this.ratings);

  factory SubjectRating.empty(String subjectId) {
    return SubjectRating._(
      subjectId,
      Map(),
    );
  }

  factory SubjectRating.fromJson(Map<String, dynamic> json) {
    return SubjectRating._(
      json["subjectId"],
      json["ratings"],
    );
  }

  double calculateAverage() {
    return ratings.keys
            .map((key) => int.parse(key) * ratings[key])
            .reduce((a, b) => a + b) /
        totalRatings();
  }

  int totalRatings() {
    return ratings.values.reduce((a, b) => a + b);
  }
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
