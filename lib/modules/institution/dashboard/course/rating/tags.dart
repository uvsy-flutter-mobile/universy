import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:optional/optional.dart';
import 'package:universy/model/institution/ratings.dart';
import 'package:universy/text/translator.dart';
import 'package:universy/text/translators/tags_rating.dart';

class SelectableTag extends StatelessWidget {
  final CourseRating _institutionCourseRate;

  SelectableTag({Key key, CourseRating courseRating})
      : _institutionCourseRate = courseRating,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TagRating> tags = Optional.ofNullable(_institutionCourseRate)
        .map((courseRate) => courseRate.tags)
        .orElse(List());
    Translator<String> tagsTranslator = TagsRatingTranslator();
    return Tags(
      itemCount: tags.length,
      itemBuilder: (int index) {
        TagRating tagRate = tags[index];
        String title = tagsTranslator.translate(tagRate.tag);
        int amountOfRates = tagRate.rating;
        return ItemTags(
          key: Key(index.toString()),
          index: index,
          activeColor: Colors.grey[350],
          color: Colors.grey[350],
          elevation: 0,
          textActiveColor: Colors.black,
          textColor: Colors.black,
          title: "$title ($amountOfRates)",
          pressEnabled: false,
          textStyle: TextStyle(
            fontSize: 14,
          ),
          combine: ItemTagsCombine.withTextBefore,
        );
      },
    );
  }
}
