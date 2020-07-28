import 'package:equatable/equatable.dart';

const int STUDENT_SUBJECT_INDEX = 0;
const int INSTITUTION_SUBJECT_INDEX = 1;
const int PROFILE_INDEX = 2;
const int SCHEDULE_INDEX = 3;

abstract class HomeState extends Equatable {
  final int index;

  HomeState(this.index);

  @override
  List<Object> get props => [index];
}

class StudentSubjectsState extends HomeState {
  StudentSubjectsState() : super(STUDENT_SUBJECT_INDEX);
}

class InstitutionSubjectsState extends HomeState {
  InstitutionSubjectsState() : super(INSTITUTION_SUBJECT_INDEX);
}

class ProfileState extends HomeState {
  ProfileState() : super(PROFILE_INDEX);
}

class ScheduleState extends HomeState {
  ScheduleState() : super(SCHEDULE_INDEX);
}
