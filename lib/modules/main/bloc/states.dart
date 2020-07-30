import 'package:equatable/equatable.dart';
import 'package:universy/modules/main/index.dart';

abstract class MainState extends Equatable {
  final int index;

  MainState(this.index);

  @override
  List<Object> get props => [index];
}

class StudentSubjectsState extends MainState {
  StudentSubjectsState() : super(STUDENT_SUBJECT_INDEX);
}

class InstitutionSubjectsState extends MainState {
  InstitutionSubjectsState() : super(INSTITUTION_SUBJECT_INDEX);
}

class ProfileState extends MainState {
  ProfileState() : super(PROFILE_INDEX);
}

class ScheduleState extends MainState {
  ScheduleState() : super(SCHEDULE_INDEX);
}
