import 'package:flutter/material.dart';
import 'package:universy/model/institution/subject.dart';
import 'package:universy/modules/institution/dashboard/subjects/correlatives/correlative_list.dart';
import 'package:universy/util/bloc.dart';

import 'states.dart';

class BoardCorrelativesStateBuilder
    extends WidgetBuilderFactory<BoardCorrelativesState> {
  @override
  Widget translate(BoardCorrelativesState state) {
    List<CorrelativeItem> correlativesToApprove = [];
    List<CorrelativeItem> correlativesToTake = [];
    if (state is CorrelativesFetchedState) {
      correlativesToApprove = state.correlativesToApprove;
      correlativesToTake = state.correlativesToTake;
    }
    return CorrelativeListWidget(
      correlativesToApprove: correlativesToApprove,
      correlativesToTake: correlativesToTake,
    );
  }
}
