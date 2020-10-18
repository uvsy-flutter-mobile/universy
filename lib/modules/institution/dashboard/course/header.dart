import 'package:flutter/material.dart';
import 'package:universy/constants/subject_level_color.dart';
import 'package:universy/model/institution/commission.dart';
import 'package:universy/model/institution/course.dart';
import 'package:universy/model/institution/subject.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/cards/rectangular.dart';
import 'package:universy/widgets/paddings/edge.dart';

class CourseHeaderWidget extends StatelessWidget {
  final Course _course;
  final Commission _commission;
  final InstitutionSubject _institutionSubject;

  CourseHeaderWidget({
    Key key,
    @required Course course,
    @required Commission commission,
    @required InstitutionSubject subject,
  })  : this._course = course,
        this._commission = commission,
        this._institutionSubject = subject,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: CircularRoundedRectangleCard(
        color: Colors.white,
        radius: 16.0,
        child: EdgePaddingWidget(
          EdgeInsets.all(15),
          Row(
            children: <Widget>[
              Expanded(
                child: _buildTitle(),
                flex: 6,
              ),
              Expanded(child: _buildCourseName(), flex: 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCourseName() {
    return Center(
      child: Text(
        _commission.name,
        style: TextStyle(
          color: getLevelColor(_institutionSubject.level),
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Center(
      child: Text(
        AppText.getInstance().get("institution.dashboard.course.title"),
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      ),
    );
  }
}
