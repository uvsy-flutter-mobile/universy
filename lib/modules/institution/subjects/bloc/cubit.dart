import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/services/exceptions/student.dart';
import 'package:universy/services/manifest.dart';

import 'states.dart';

class InstitutionSubjectsCubit extends Cubit<InstitutionSubjectsState> {
  final StudentCareerService _studentCareerService;
  final InstitutionService _institutionService;

  InstitutionSubjectsCubit(
    this._studentCareerService,
    this._institutionService,
  ) : super(LoadingState());

  Future<void> fetchSubjects() async {
    try {
      emit(LoadingState());
      var programId = await _studentCareerService.getCurrentProgram();
      var institutionSubjects =
          await _institutionService.getSubjects(programId);

      institutionSubjects.sort((a, b) => a.level.compareTo(b.level));
      if (institutionSubjects.isNotEmpty) {
        emit(DisplayState(institutionSubjects));
      } else {
        emit(EmptyState());
      }
    } on CurrentProgramNotFound {
      emit(CareerNotCreatedState());
    }
  }
}
