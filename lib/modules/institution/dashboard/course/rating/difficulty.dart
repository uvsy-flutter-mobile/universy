import 'package:flutter/material.dart';
import 'package:universy/model/institution/ratings.dart';
import 'package:universy/text/text.dart';

class CourseDifficultyRate extends StatelessWidget {
  final CourseRating _institutionCourseRate;
  static const TOTAL = "/5";

  CourseDifficultyRate({Key key, CourseRating courseRating})
      : _institutionCourseRate = courseRating,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    String difficulty =
        _institutionCourseRate.calculateDifficulty().toStringAsFixed(2);
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _getDifficultyNumber(difficulty),
              _getDifficultyMax(),
            ],
          ),
          _getTextDifficulty(),
        ],
      ),
    );
  }

  Widget _getDifficultyMax() {
    return Text(
      TOTAL,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 18, color: Colors.grey),
    );
  }

  Widget _getDifficultyNumber(difficulty) {
    return Text(
      difficulty,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 30, color: Colors.grey),
    );
  }

  Widget _getTextDifficulty() {
    return Center(
      child: Text(
        AppText.getInstance()
            .get("institution.dashboard.course.labels.difficulty"),
        style: TextStyle(color: Colors.grey),
        textAlign: TextAlign.center,
      ),
    );
  }
}
