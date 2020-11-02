import 'package:equatable/equatable.dart';
import 'package:universy/model/institution/subject.dart';
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
  final List<ScheduleScratchCourse> scratchCourses;
  final List<int> levels;
  final List<InstitutionSubject> subjects;

  CreateScratchState(
      this.scratch, this.scratchCourses, this.levels, this.subjects);
}

class EditScratchState extends ScheduleState {
  final StudentScheduleScratch scratch;
  final List<ScheduleScratchCourse> scratchCourses;
  final List<int> levels;
  final List<InstitutionSubject> subjects;

  EditScratchState(
      this.scratch, this.scratchCourses, this.levels, this.subjects);
}
