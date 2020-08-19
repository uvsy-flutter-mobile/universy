import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/services/manifest.dart';

import 'states.dart';

class EnrollCubit extends Cubit<EnrollState> {
  final StudentCareerService _studentCareerService;
  final InstitutionService _institutionService;

  EnrollCubit(this._studentCareerService, this._institutionService)
      : super(InstitutionState());

  void nextStep() {
    if (state is InstitutionState) {
      emit(CareerState());
    } else if (state is CareerState) {
      emit(YearState());
    } else if (state is YearState) {
      emit(ReviewState());
    }
  }

  void previousStep() {
    if (state is CareerState) {
      emit(InstitutionState());
    } else if (state is YearState) {
      emit(CareerState());
    } else if (state is ReviewState) {
      emit(YearState());
    }
  }
}
