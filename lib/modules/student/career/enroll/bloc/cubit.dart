import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/model/institution/career.dart';
import 'package:universy/model/institution/enrollment.dart';
import 'package:universy/model/institution/institution.dart';
import 'package:universy/model/institution/program.dart';
import 'package:universy/services/manifest.dart';

import 'states.dart';

class EnrollCubit extends Cubit<EnrollState> {
  final StudentCareerService _studentCareerService;
  final InstitutionService _institutionService;
  final CareerEnrollment _enrollment;

  EnrollCubit(this._studentCareerService, this._institutionService)
      : this._enrollment = CareerEnrollment(),
        super(LoadingState());

  void fetchInstitutions() async {
    emit(FetchingData(0));
    var institutions = await _institutionService.getInstitutions();
    emit(InstitutionState(institutions));
  }

  void selectInstitution(Institution institution) async {
    _enrollment.institution = institution;
    emit(FetchingData(1));
    var careers = await _institutionService.getCareers(institution);
    emit(CareerState(careers));
  }

  void reloadCareers() {
    this.selectInstitution(_enrollment.institution);
  }

  void selectCareer(InstitutionCareer career) async {
    _enrollment.institutionCareer = career;
    emit(FetchingData(2));
    var programs = await _institutionService.getPrograms(career);
    emit(ProgramsState(programs));
  }

  void reloadPrograms() {
    this.selectCareer(_enrollment.institutionCareer);
  }

  Future<void> selectProgram(InstitutionProgram program, int beginYear) async {
    _enrollment.institutionProgram = program;
    emit(ReviewState(_enrollment));
  }

  Future<void> createCareer(InstitutionProgram program, int beginYear) async {
    await _studentCareerService.createCareer(program.id, beginYear);
  }
}
