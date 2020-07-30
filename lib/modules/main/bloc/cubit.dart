import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/modules/main/bloc/states.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(StudentSubjectsState());

  void toStudentSubjects() {
    emit(StudentSubjectsState());
  }

  void toProfile() {
    emit(ProfileState());
  }

  void toInstitutionSubjects() {
    emit(InstitutionSubjectsState());
  }

  void toScheduleSubjects() {
    emit(ScheduleState());
  }
}
