import 'package:equatable/equatable.dart';
import 'package:universy/model/student/schedule.dart';

abstract class ScheduleState extends Equatable {
  List<Object> get props => [];
}

class LoadingState extends ScheduleState {}

class ScratchesNotFound extends ScheduleState {}

class DisplayScratchesState extends ScheduleState {
  final List<StudentScheduleScratch> scratches;

  DisplayScratchesState(this.scratches);

  List<Object> get props => [scratches];
}

class CareerNotCreatedState extends ScheduleState {}
