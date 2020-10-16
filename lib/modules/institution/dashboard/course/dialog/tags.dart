import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:universy/model/institution/ratings.dart';

class StudentCourseRageTagsWidget extends StatelessWidget {
  final Set<String> studentTags;
  final Function(dynamic, bool) onTagPressed;

  StudentCourseRageTagsWidget({
    Key key,
    @required List<String> selectedTags,
    Function(dynamic, bool) onTagPressed,
  })  : this.studentTags = HashSet.from(selectedTags),
        this.onTagPressed = onTagPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CourseTag> courseTags = CourseTag.getCourseTags();
    return FittedBox(
      fit: BoxFit.fitHeight,
      alignment: Alignment.center,
      child: SizedBox(
        width: 350,
        child: Tags(
          itemCount: courseTags.length,
          itemBuilder: (int index) {
            final tag = courseTags[index];
            return ItemTags(
              key: Key(index.toString()),
              index: index,
              title: tag.description,
              pressEnabled: true,
              elevation: 1,
              color: Color(0xFFfafafa),
              borderRadius: BorderRadius.all(Radius.circular(8)),
              border: Border.all(color: Color(0xFFe6e6e6), width: 1),
              activeColor: Colors.orange,
              textStyle: TextStyle(
                fontSize: 14,
              ),
              combine: ItemTagsCombine.withTextBefore,
              onPressed: (_) => _pressTag(tag),
              active: _isTagOnTagList(tag),
            );
          },
        ),
      ),
    );
  }

  void _pressTag(CourseTag courseTag) {
    bool pressTag = !_isTagOnTagList(courseTag);
    onTagPressed(courseTag.tag, pressTag);
  }

  bool _isTagOnTagList(CourseTag courseTag) {
    return studentTags.contains(courseTag.tag);
  }
}
