import 'package:flutter/material.dart';
import 'package:universy/modules/institution/dashboard/subjects/header/back_card.dart';
import 'package:universy/modules/institution/dashboard/subjects/header/bloc/states.dart';
import 'package:universy/util/bloc.dart';
import 'package:universy/widgets/progress/circular.dart';

import 'states.dart';

class HeaderBackCardStateBuilder
    extends WidgetBuilderFactory<SubjectHeaderState> {
  @override
  Widget translate(SubjectHeaderState state) {
    if (state is StudentRatingFetchedState) {
      return SubjectHeaderBackCard.from(state.studentSubjectRating);
    } else if (state is StudentRatingNotFoundState) {
      return SubjectHeaderBackCard.empty();
    }
    return CenterSizedCircularProgressIndicator();
  }
}
