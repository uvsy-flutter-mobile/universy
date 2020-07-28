import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/modules/home/bloc/states.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(StudentSubjectsState());

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
