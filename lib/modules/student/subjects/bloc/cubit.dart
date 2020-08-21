import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/services/exceptions/student.dart';
import 'package:universy/services/manifest.dart';

import 'states.dart';

class SubjectCubit extends Cubit<SubjectState> {
  final StudentCareerService _studentCareerService;

  SubjectCubit(this._studentCareerService) : super(LoadingState());

  Future<void> fetchSubjects() async {
    try {
      emit(LoadingState());
      var userId = await _studentCareerService.getCurrentProgram();
      emit(DisplayState());
    } on CurrentProgramNotFound {
      emit(CareerNotCreatedState());
    }
  }
}
