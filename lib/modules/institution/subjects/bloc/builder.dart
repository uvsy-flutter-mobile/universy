import 'package:flutter/material.dart';
import 'package:universy/modules/institution/subjects/not_found.dart';
import 'package:universy/util/bloc.dart';
import 'package:universy/widgets/progress/circular.dart';

import 'states.dart';

class InstitutionSubjectsStateBuilder
    extends WidgetBuilderFactory<InstitutionSubjectsState> {
  @override
  Widget translate(InstitutionSubjectsState state) {
    if (state is DisplayState) {
      return Container(child: Center(child: Text("Nada pa ve")));
    } else if (state is CareerNotCreatedState) {
      return CareerNotFoundWidget();
    }
    return CenterSizedCircularProgressIndicator();
  }
}