import 'package:flutter/material.dart';
import 'package:universy/modules/institution/dashboard/course/bloc/states.dart';
import 'package:universy/modules/institution/dashboard/course/rating/not_found.dart';
import 'package:universy/modules/institution/dashboard/course/rating/rating.dart';
import 'package:universy/util/bloc.dart';
import 'package:universy/widgets/progress/circular.dart';

class InstitutionCourseRateBuilder extends WidgetBuilderFactory {
  @override
  Widget translate(state) {
    if (state is CourseRatingInitialState) {
      return CenterSizedCircularProgressIndicator();
    } else if (state is CourseRatingReceivedState) {
      return CourseRateWidget(institutionCourseRate: state.courseRating);
    } else {
      return CourseRateNotExistingWidget();
    }
  }
}
