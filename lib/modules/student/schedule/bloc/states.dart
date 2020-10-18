import 'package:equatable/equatable.dart';

abstract class ScheduleState extends Equatable {
  List<Object> get props => [];
}

class LoadingState extends ScheduleState {}

class ScratchesNotFound extends ScheduleState {}

class DisplayScratchesState extends ScheduleState {}

class EditScratchState extends ScheduleState {}

class AddScratchState extends ScheduleState {}
