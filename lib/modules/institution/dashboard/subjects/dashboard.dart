import 'package:flutter/material.dart';
import 'package:universy/model/institution/subject.dart';
import 'package:universy/modules/institution/dashboard/subjects/correlatives.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/paddings/edge.dart';

import 'courses.dart';
import 'header.dart';

class SubjectBoardModule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          AppText.getInstance().get("institution.dashboard.subject.title"),
        ),
      ),
      body: buildBoard(context),
    );
  }

  Widget buildBoard(BuildContext context) {
    InstitutionSubject subject = ModalRoute.of(context).settings.arguments;
    return AllEdgePaddedWidget(
      padding: 10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(child: _buildHeader(subject), flex: 6),
          Expanded(child: _getCoursesAndCorrelatives(subject), flex: 14),
        ],
      ),
    );
  }

  Widget _buildHeader(InstitutionSubject subject) {
    return SubjectBoardHeader(subject: subject);
  }

  Widget _getCoursesAndCorrelatives(InstitutionSubject subject) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(child: _buildCourseColumn(subject), flex: 25),
        Expanded(child: _getCorrelatives(subject), flex: 80),
      ],
    );
  }

  Widget _buildCourseColumn(InstitutionSubject subject) {
    return SubjectBoardCourses(subject: subject);
  }

  Widget _getCorrelatives(InstitutionSubject subject) {
    return SubjectBoardCorrelatives(subject: subject);
  }
}
