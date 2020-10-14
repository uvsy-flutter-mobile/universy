import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:universy/constants/subject_level_color.dart';
import 'package:universy/model/institution/couse.dart';
import 'package:universy/model/institution/subject.dart';

import 'item.dart';

const CAROUSEL_HEIGHT = 80.0;

class CoursesListWidget extends StatelessWidget {
  final InstitutionSubject subject;
  final List<Course> courses;
  final Map<String, Commission> commissions;

  CoursesListWidget({
    Key key,
    InstitutionSubject subject,
    List<Course> courses,
    Map<String, Commission> commissions,
  })  : this.subject = subject,
        this.courses = courses,
        this.commissions = commissions,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadingEdgeScrollView.fromScrollView(
      child: ListView.builder(
        controller: ScrollController(),
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: courses.length,
        itemBuilder: _getCoursesListBuilder(),
      ),
    );
  }

  IndexedWidgetBuilder _getCoursesListBuilder() {
    return (BuildContext context, int index) {
      Course course = courses[index];
      return _buildItem(
        index: index,
        color: getLevelColor(subject.level),
        textColor: getLevelTextColor(subject.level),
        parentSize: CAROUSEL_HEIGHT,
        course: course,
      );
    };
  }

  Widget _buildItem(
      {int index,
      Color color,
      Color textColor,
      double parentSize,
      Course course}) {
    double edgeSize = 2.0;
    double itemSize = parentSize - edgeSize * 2.0;
    return Container(
      padding: EdgeInsets.all(edgeSize),
      child: CourseItemWidget(
        itemSize: itemSize,
        color: color,
        textColor: textColor,
        course: course,
        commission: commissions[course.commissionId],
        institutionSubject: subject,
      ),
    );
  }
}
