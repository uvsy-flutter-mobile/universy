import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/model/student/schedule.dart';
import 'package:universy/services/exceptions/student.dart';
import 'package:universy/services/impl/student/career.dart';
import 'package:universy/services/manifest.dart';

import 'states.dart';

class ScheduleCubit extends Cubit<ScheduleState> {
  final StudentScheduleService _scheduleService;

  ScheduleCubit(this._scheduleService) : super(LoadingState());

  Future<void> fetchScratches() async {
    try {
      emit(LoadingState());
      var programId =
          await DefaultStudentCareerService.instance().getCurrentProgram();
      /* var scheduleScratches = await _scheduleService.getScratches(programId);*/
      List<StudentScheduleScratch> scheduleScratches = [];
      StudentScheduleScratch scheduleScratch =
          new StudentScheduleScratch.empty("Mi horario", 042020, 072020);
      scheduleScratches.add(scheduleScratch);
      if (scheduleScratches.isNotEmpty) {
        emit(DisplayScratchesState(scheduleScratches));
      } else {
        emit(EmptyScratches());
      }
    } on CurrentProgramNotFound {
      emit(CareerNotCreatedState());
    }
  }

  Future<void> createScratch(
      StudentScheduleScratch studentScheduleScratch) async {
    /*await _scheduleService.createScratch(studentScheduleScratch);*/
  }

  Future<void> updateScratch(
      StudentScheduleScratch studentScheduleScratch) async {
    /* await _scheduleService.updateScratch(studentScheduleScratch);*/
  }

  Future<void> deleteScratch(String scratchId) async {
    /*await _scheduleService.deleteScratch(scratchId);*/
  }

  void createScratchSchedule(StudentScheduleScratch studentScheduleScratch) {
    emit(CreateScratchState(studentScheduleScratch));
  }

  void editScratchSchedule(StudentScheduleScratch studentScheduleScratch) {
    emit(EditScratchState(studentScheduleScratch));
  }
}
