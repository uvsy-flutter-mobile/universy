import 'package:equatable/equatable.dart';
import 'package:universy/model/student/schedule.dart';

abstract class ScheduleState extends Equatable {
  List<Object> get props => [];

  get scratch => scratch;
}

class LoadingState extends ScheduleState {}

class EmptyScratches extends ScheduleState {}

class DisplayScratchesState extends ScheduleState {
  final List<StudentScheduleScratch> scratches;

  DisplayScratchesState(this.scratches);

  List<Object> get props => [scratches];
}

class CareerNotCreatedState extends ScheduleState {}

class CreateScratchState extends ScheduleState {
  final StudentScheduleScratch scratch;

  CreateScratchState(this.scratch);
}

class EditScratchState extends ScheduleState {
  final StudentScheduleScratch scratch;

  EditScratchState(this.scratch);
}
