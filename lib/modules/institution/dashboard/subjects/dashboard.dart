import 'package:flutter/material.dart';
import 'package:universy/model/institution/subject.dart';
import 'package:universy/modules/institution/dashboard/subjects/correlatives.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/cards/rectangular.dart';
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
        Expanded(child: _buildCorrelativesAndPoints(subject), flex: 80),
      ],
    );
  }

  Widget _buildCorrelativesAndPoints(InstitutionSubject subject) {
    return Column(
      children: <Widget>[
        subject.isOptative() ? _getHoursAndPoints(subject) : Container(),
        _getCorrelatives(subject),
      ],
    );
  }

  Widget _getHoursAndPoints(InstitutionSubject subject) {
    int points = subject.points;
    int hours = subject.hours;
    return CircularRoundedRectangleCard(
      elevation: 5,
      color: Colors.white,
      radius: 10.0,
      child: AllEdgePaddedWidget(
          padding: 10,
          child: Container(
              child: _buildTextPointsAndHours(points, hours),
              width: double.infinity)),
    );
  }

  Widget _buildTextPointsAndHours(int points, int hours) {
    return Column(
      children: <Widget>[
        Text("Esta materia te suma"),
        _buildTextPoints(points),
        _buildTextHours(hours),
      ],
    );
  }

  Widget _buildTextPoints(int points) {
    if (points != 0) {
      return Text("Puntos: $points");
    } else {
      return Container();
    }
  }

  Widget _buildTextHours(int hours) {
    if (hours != 0) {
      return Text("Horas: $hours");
    } else {
      return Container();
    }
  }

  Widget _buildCourseColumn(InstitutionSubject subject) {
    return SubjectBoardCourses(subject: subject);
  }

  Widget _getCorrelatives(InstitutionSubject subject) {
    return SubjectBoardCorrelatives(subject: subject);
  }
}
