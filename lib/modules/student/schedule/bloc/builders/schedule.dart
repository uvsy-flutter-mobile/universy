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
    if (state is EmptyScratches) {
      return EmptyScratchesWidget();
    } else if (state is DisplayScratchesState) {
      return DisplayScratchesWidget(scheduleScratches: state.scratches);
    } else if (state is CareerNotCreatedState) {
      return CareerNotFoundWidget();
    } else if (state is CreateScratchState) {
      return ScratchView(create: true, scratch: state.scratch);
    } else if (state is EditScratchState) {
      return ScratchView(create: false, scratch: state.scratch);
    }
    return CenterSizedCircularProgressIndicator();
  }
}

/*StudentScheduleScratch scheduleScratch =
new StudentScheduleScratch.empty("Mi horario", 042020, 072020);
return ScratchView(scratch: scheduleScratch, create: false);*/
