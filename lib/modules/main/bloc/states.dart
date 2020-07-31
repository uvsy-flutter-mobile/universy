import 'package:equatable/equatable.dart';
import 'package:universy/modules/main/index.dart';

abstract class MainState extends Equatable {
  final int index;
  final String moduleName;

  MainState(this.index, this.moduleName);

  @override
  List<Object> get props => [index];
}

class StudentSubjectsState extends MainState {
  StudentSubjectsState() : super(STUDENT_SUBJECT_INDEX, "studentSubjects");
}

class InstitutionSubjectsState extends MainState {
  InstitutionSubjectsState()
      : super(INSTITUTION_SUBJECT_INDEX, "institutionSubjects");
}

class ProfileState extends MainState {
  ProfileState() : super(PROFILE_INDEX, "profile");
}
