import 'package:universy/model/json.dart';
import 'package:universy/text/translator.dart';
import 'package:universy/text/translators/tags_rating.dart';

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
  Map<String, dynamic> overall;
  Map<String, dynamic> difficulty;
  int wouldTakeAgain;
  int wouldNotTakeAgain;
  List<TagRating> tagsRating;

  List<TagRating> get tags => tagsRating.toList();

  CourseRating(
    this.courseId,
    this.overall,
    this.difficulty,
    this.wouldTakeAgain,
    this.wouldNotTakeAgain,
    this.tagsRating,
  );

  double calculateDifficulty() {
    int amount = difficulty.values.reduce((a, b) => a + b);
    return difficulty.keys
            .map((key) => int.parse(key) * difficulty[key])
            .reduce((a, b) => a + b) /
        amount;
  }

  double calculateOverAll() {
    int amount = overall.values.reduce((a, b) => a + b);
    return overall.keys
            .map((key) => int.parse(key) * overall[key])
            .reduce((a, b) => a + b) /
        amount;
  }

  int calculatePercentage() {
    int wouldTakeAgain = this.wouldTakeAgain;
    int wouldNotTakeAgain = this.wouldNotTakeAgain;
    return ((wouldTakeAgain / (wouldTakeAgain + wouldNotTakeAgain)) * 100)
        .toInt();
  }

  factory CourseRating.fromJson(Map<String, dynamic> json) {
    List<TagRating> tagsRating = (json["tagsRating"] as List)
        .map(
          (unitTag) => TagRating.fromJson(unitTag),
        )
        .toList();
    return CourseRating(
      json["courseId"],
      json["overall"],
      json["difficulty"],
      json["wouldTakeAgain"],
      json["wouldNotTakeAgain"],
      tagsRating,
    );
  }
}

class TagRating implements JsonConvertible {
  String tag;
  int rating;

  TagRating(this.tag, this.rating);

  factory TagRating.fromJson(Map<String, dynamic> json) {
    return TagRating(json["tag"], json["rating"]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "tag": tag,
      "rating": rating,
    };
  }
}

abstract class Tag {
  static const HARD_PRACTICAL = "HARD_PRACTICAL";
  static const HARD_THEORETICAL = "HARD_THEORETICAL";
  static const MANDATORY_CLASS = "MANDATORY_CLASS";
  static const HARD_TO_UNDERSTAND = "HARD_TO_UNDERSTAND";
  static const PROMOTIONABLE = "PROMOTIONABLE";
  static const DONT_GO_THERE = "DONT_GO_THERE";
  static const MIND_BLOWING = "MIND_BLOWING";
  static const BE_READY_FOR_PW = "BE_READY_FOR_PW";
  static const TO_MUCH_EXTRA_TIME = "TO_MUCH_EXTRA_TIME";
  static const SUMMARIES_AVAILABLE = "SUMMARIES_AVAILABLE";

  static List<String> values() {
    return [
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
    ];
  }
}

class CourseTag implements JsonConvertible {
  final String _tag;
  final String _description;

  CourseTag(this._tag, this._description);

  String get tag => _tag;

  String get description => _description;

  @override
  Map<String, String> toJson() {
    return {
      "tag": _tag.toString(),
      "description": _description,
    };
  }

  static List<CourseTag> getCourseTags() {
    Translator<String> tagsTranslator = TagsRatingTranslator();
    return Tag.values()
        .map((tag) => CourseTag(tag, tagsTranslator.translate(tag)))
        .toList();
  }
}
