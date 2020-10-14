import 'package:flutter/material.dart';
import 'package:universy/modules/institution/dashboard/subjects/courses/display.dart';
import 'package:universy/modules/institution/dashboard/subjects/courses/empty.dart';
import 'package:universy/util/bloc.dart';
import 'package:universy/widgets/progress/circular.dart';

import 'states.dart';

class BoardCoursesStateBuilder extends WidgetBuilderFactory<BoardCoursesState> {
  @override
  Widget translate(BoardCoursesState state) {
    if (state is CoursesFetchedState) {
      return CoursesListWidget(
        subject: state.subject,
        courses: state.courses,
        commissions: state.commissions,
      );
    } else if (state is EmptyCoursesState) {
      return EmptyCoursesWidget();
    }
    return CenterSizedCircularProgressIndicator();
  }
}
