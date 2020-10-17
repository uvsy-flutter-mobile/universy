import 'package:flutter/material.dart';
import 'package:universy/model/institution/ratings.dart';
import 'package:universy/text/text.dart';

class CourseTakenAgainRate extends StatelessWidget {
  final CourseRating _institutionCourseRate;
  static const UNIT = "%";

  CourseTakenAgainRate({Key key, CourseRating courseRating})
      : _institutionCourseRate = courseRating,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    int percentage = _institutionCourseRate.calculatePercentage();
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _getPercentageText(percentage),
              _getPercentageMax(),
            ],
          ),
          _getTextTakenAgain()
        ],
      ),
    );
  }

  Widget _getPercentageText(int percentage) {
    return Text(
      percentage.toString(),
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 30, color: Colors.grey),
    );
  }

  Widget _getPercentageMax() {
    return Text(
      UNIT,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 18, color: Colors.grey),
    );
  }

  Widget _getTextTakenAgain() {
    return Center(
      child: Text(
        AppText.getInstance()
            .get("institution.dashboard.course.labels.wouldTakeAgain"),
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.grey),
      ),
    );
  }
}
