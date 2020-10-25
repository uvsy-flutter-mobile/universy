import 'package:flutter/material.dart';
import 'package:universy/model/student/schedule.dart';
import 'package:universy/modules/student/schedule/bloc/states.dart';
import 'package:universy/modules/student/schedule/display.dart';
import 'package:universy/modules/student/schedule/empty.dart';
import 'package:universy/modules/student/schedule/not_found.dart';
import 'package:universy/modules/student/schedule/scratch_view.dart';
import 'package:universy/util/bloc.dart';
import 'package:universy/widgets/progress/circular.dart';

class ScheduleStateBuilder extends WidgetBuilderFactory<ScheduleState> {
  @override
  Widget translate(ScheduleState state) {
    if (state is ScratchesNotFound) {
      return ScratchesNotFoundWidget();
    } else if (state is DisplayScratchesState) {
      return DisplayScratchesWidget(
          /*scratches: state.scheduleScratches,*/);
    } else if (state is CareerNotCreatedState) {
      return CareerNotFoundWidget();
    }
    return CenterSizedCircularProgressIndicator();
  }
}

/*StudentScheduleScratch scheduleScratch =
new StudentScheduleScratch.empty("Mi horario", 042020, 072020);
return ScratchView(scratch: scheduleScratch, create: false);*/
