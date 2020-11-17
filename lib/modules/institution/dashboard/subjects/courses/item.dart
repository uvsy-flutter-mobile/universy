import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:universy/constants/routes.dart';
import 'package:universy/model/institution/commission.dart';
import 'package:universy/model/institution/course.dart';
import 'package:universy/model/institution/subject.dart';
import 'package:universy/modules/institution/dashboard/course/dashboard.dart';
import 'package:universy/widgets/inkwell/clipped.dart';

class CourseItemWidget extends StatelessWidget {
  final double _itemSize;
  final Color _color;
  final Color _textColor;
  final Commission commission;
  final Course course;
  final InstitutionSubject subject;

  CourseItemWidget(
      {Key key,
      @required double itemSize,
      @required Color color,
      @required Color textColor,
      @required Course course,
      @required Commission commission,
      @required InstitutionSubject institutionSubject})
      : this._itemSize = itemSize,
        this._color = color,
        this._textColor = textColor,
        this.course = course,
        this.commission = commission,
        this.subject = institutionSubject,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _itemSize,
      height: _itemSize,
      child: ClippedInkWell(
        splashColor: Colors.blue,
        radius: 16.0,
        color: _color,
        onTap: () => _navigateToSubjectBoardView(context),
        child: Container(
          alignment: AlignmentDirectional.center,
          child: Center(
            child: AutoSizeText(
              commission.name,
              style: TextStyle(fontSize: 28.0, color: _textColor),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToSubjectBoardView(BuildContext context) {
    var arguments = CourseBoardModuleArguments(subject, commission, course);
    Navigator.pushNamed(context, Routes.COURSE_BOARD_MODULE,
        arguments: arguments);
  }
}
