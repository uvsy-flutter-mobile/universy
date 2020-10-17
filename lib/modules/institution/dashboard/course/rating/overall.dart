import 'package:flutter/material.dart';
import 'package:universy/model/institution/ratings.dart';
import 'package:universy/text/text.dart';

class CourseOverallRate extends StatelessWidget {
  final CourseRating _institutionCourseRate;
  static const TOTAL = "/5";

  CourseOverallRate({Key key, CourseRating courseRating})
      : _institutionCourseRate = courseRating,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    String overall =
        _institutionCourseRate.calculateOverAll().toStringAsFixed(2);
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _getOverallNumber(overall),
              _getOverallMax(),
            ],
          ),
          _getTextOverAll(),
        ],
      ),
    );
  }

  Widget _getOverallNumber(String overall) {
    return Text(
      overall,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 33,
      ),
    );
  }

  Widget _getOverallMax() {
    return Text(
      TOTAL,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 18,
      ),
    );
  }

  Widget _getTextOverAll() {
    return Center(
      child: Text(
        AppText.getInstance()
            .get("institution.dashboard.course.labels.general"),
        textAlign: TextAlign.center,
      ),
    );
  }
}
