import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/business/subjects/matcher/matcher.dart';
import 'package:universy/services/exceptions/student.dart';
import 'package:universy/services/manifest.dart';

import 'states.dart';

class SubjectCubit extends Cubit<SubjectState> {
  final StudentCareerService _studentCareerService;
  final InstitutionService _institutionService;

  SubjectCubit(this._studentCareerService, this._institutionService)
      : super(LoadingState());

  Future<void> fetchSubjects() async {
    try {
      emit(LoadingState());
      var programId = await _studentCareerService.getCurrentProgram();
      var institutionSubjects =
          await _institutionService.getSubjects(programId);
      var studentSubjects = await _studentCareerService.getSubjects(programId);
      var subjects =
          SubjectMatcher().apply(institutionSubjects, studentSubjects);

      if (subjects.isNotEmpty) {
        emit(DisplayState(subjects));
      } else {
        emit(EmptyState());
      }
    } on CurrentProgramNotFound {
      emit(CareerNotCreatedState());
    }
  }
}
