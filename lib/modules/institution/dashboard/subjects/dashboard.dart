import 'package:flutter/material.dart';
import 'package:universy/model/institution/subject.dart';
import 'package:universy/widgets/paddings/edge.dart';

import 'header.dart';

class SubjectBoardModule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Ver Cátedra")),
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
          Expanded(child: _getCoursesAndCorrelatives(context), flex: 14),
        ],
      ),
    );
  }

  Widget _buildHeader(InstitutionSubject subject) {
    return SubjectBoardHeader(subject: subject);
  }

  Widget _getCoursesAndCorrelatives(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(child: _buildCourseColumn(context), flex: 25),
        Expanded(child: _getCorrelatives(), flex: 80),
      ],
    );
  }

  Widget _buildCourseColumn(BuildContext context) {
    return Container();
  }

  Widget _getCorrelatives() {
    return Container();
  }
}
