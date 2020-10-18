import 'package:flutter/material.dart';
import 'package:universy/modules/student/schedule/bloc/states.dart';
import 'package:universy/modules/student/schedule/display.dart';
import 'package:universy/modules/student/schedule/not_found.dart';
import 'package:universy/util/bloc.dart';
import 'package:universy/widgets/progress/circular.dart';

class ScheduleStateBuilder extends WidgetBuilderFactory<ScheduleState> {
  @override
  Widget translate(ScheduleState state) {
    if (state is ScratchesNotFound) {
      return ScratchesNotFoundWidget();
    } else if (state is DisplayScratchesState) {
      return DisplayScratchesWidget(
          /*scratches: state.scheduleScratches,*/
          );
    }
    return CenterSizedCircularProgressIndicator();
  }
}
