import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/services/exceptions/student.dart';
import 'package:universy/services/manifest.dart';

import 'states.dart';

class InstitutionSubjectsCubit extends Cubit<InstitutionSubjectsState> {
  final StudentCareerService _studentCareerService;

  InstitutionSubjectsCubit(this._studentCareerService) : super(LoadingState());

  Future<void> toDisplay() async {
    try {
      var userId = await _studentCareerService.getCurrentProgram();
      emit(DisplayState());
    } on CurrentProgramNotFound {
      emit(CareerNotCreatedState());
    }
  }
}
