import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/services/manifest.dart';

import 'states.dart';

class ScheduleCubit extends Cubit<ScheduleState> {
  /*final StudentScheduleService _scheduleService; */

  /*ScheduleCubit(this._scheduleService) : super(LoadingState());*/ //TODO: with backend

  ScheduleCubit() : super(LoadingState());

  Future<void> fetchNotes() async {
    emit(LoadingState());

    emit(DisplayScratchesState());
    /*
      List<StudentScheduleScratch> scheduleScratches = await _scheduleService.getScratches();

      if (scheduleScratches.isNotEmpty) {
        var displayScratches = List<ScheduleScratch>.of(scheduleScratches);
        emit(DisplayScratchesState(displayScratches));
      } else {
        emit(ScratchesNotFound());
      }*/
  }
}
