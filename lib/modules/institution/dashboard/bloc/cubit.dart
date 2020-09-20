import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/model/institution/subject.dart';
import 'package:universy/services/exceptions/student.dart';
import 'package:universy/services/manifest.dart';

import 'states.dart';

class SubjectBoardCubit extends Cubit<SubjectBoardState> {
  final InstitutionSubject _subject;
  final RatingsService _ratingService;
  final InstitutionService _institutionService;

  SubjectBoardCubit(
    this._subject,
    this._ratingService,
    this._institutionService,
  ) : super(LoadingState());

  Future<void> loadBoard() async {
    emit(LoadingState());
  }
}
