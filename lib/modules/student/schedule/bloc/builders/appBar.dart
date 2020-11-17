import 'package:flutter/material.dart';
import 'package:universy/modules/student/schedule/bloc/states.dart';
import 'package:universy/modules/student/schedule/widgets/schedule_app_bar.dart';
import 'package:universy/util/bloc.dart';

class AppBarStateBuilder extends WidgetBuilderFactory<ScheduleState> {
  @override
  Widget translate(ScheduleState state) {
    if (state is CreateScratchState || state is EditScratchState) {
      return ScratchAppBar(title: state.scratch.name);
    }
    return ScheduleMainAppBar();
  }
}
