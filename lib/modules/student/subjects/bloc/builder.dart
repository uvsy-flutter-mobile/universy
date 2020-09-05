import 'package:flutter/material.dart';
import 'package:universy/modules/student/subjects/display.dart';
import 'package:universy/modules/student/subjects/empty.dart';
import 'package:universy/modules/student/subjects/not_found.dart';
import 'package:universy/util/bloc.dart';
import 'package:universy/widgets/progress/circular.dart';

import 'states.dart';

class SubjectStateBuilder extends WidgetBuilderFactory<SubjectState> {
  @override
  Widget translate(SubjectState state) {
    if (state is DisplayState) {
      return SubjectsDisplayWidget(subjects: state.subjects);
    } else if (state is CareerNotCreatedState) {
      return CareerNotFoundWidget();
    } else if (state is EmptyState) {
      return EmptySubjectsWidget();
    }
    return CenterSizedCircularProgressIndicator();
  }
}
