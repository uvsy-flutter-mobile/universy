import 'package:flutter/material.dart';
import 'package:universy/modules/institution/dashboard/subjects/header/bloc/front/states.dart';
import 'package:universy/modules/institution/dashboard/subjects/header/bloc/states.dart';
import 'package:universy/modules/institution/dashboard/subjects/header/front_card.dart';
import 'package:universy/util/bloc.dart';
import 'package:universy/widgets/progress/circular.dart';

class HeaderFrontCardStateBuilder
    extends WidgetBuilderFactory<SubjectHeaderState> {
  @override
  Widget translate(SubjectHeaderState state) {
    if (state is SubjectRatingFetchedState) {
      return SubjectHeaderFrontCard.from(state.subject, state.subjectRating);
    } else if (state is SubjectRatingNotFound) {
      return SubjectHeaderFrontCard.empty(state.subject);
    }
    return CenterSizedCircularProgressIndicator();
  }
}
