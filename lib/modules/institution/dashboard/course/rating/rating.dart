import 'package:flutter/material.dart';
import 'package:universy/model/institution/ratings.dart';
import 'package:universy/modules/institution/dashboard/course/rating/tags.dart';
import 'package:universy/modules/institution/dashboard/course/rating/take_again.dart';
import 'package:universy/widgets/paddings/edge.dart';

import 'difficulty.dart';
import 'overall.dart';

class CourseRateWidget extends StatelessWidget {
  final CourseRating _institutionCourseRate;

  CourseRateWidget({Key key, CourseRating institutionCourseRate})
      : this._institutionCourseRate = institutionCourseRate,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        _buildStatsRow(_institutionCourseRate),
        Divider(),
        _buildTags(_institutionCourseRate)
      ],
    );
  }

  Widget _buildTags(CourseRating institutionCourseRate) {
    return SymmetricEdgePaddingWidget.vertical(
      paddingValue: 10,
      child:
          Container(child: SelectableTag(courseRating: institutionCourseRate)),
    );
  }

  Widget _buildStatsRow(CourseRating institutionCourseRate) {
    return SymmetricEdgePaddingWidget.vertical(
      paddingValue: 10,
      child: SymmetricEdgePaddingWidget.horizontal(
        paddingValue: 5,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CourseOverallRate(courseRating: institutionCourseRate),
            CourseDifficultyRate(courseRating: institutionCourseRate),
            CourseTakenAgainRate(courseRating: institutionCourseRate)
          ],
        ),
      ),
    );
  }
}
