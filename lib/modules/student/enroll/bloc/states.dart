import 'package:equatable/equatable.dart';
import 'package:universy/model/institution/career.dart';
import 'package:universy/model/institution/enrollment.dart';
import 'package:universy/model/institution/institution.dart';
import 'package:universy/model/institution/program.dart';

import 'steps.dart';

abstract class EnrollState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadingState extends EnrollState {}

class BaseStepState extends EnrollState {
  final int step;

  BaseStepState(this.step);

  @override
  List<Object> get props => [step];
}

class FetchingData extends BaseStepState {
  FetchingData(int step) : super(step);
}

class InstitutionState extends BaseStepState {
  final List<Institution> institutions;

  InstitutionState(this.institutions) : super(Step.institution.index);
}

class CareerState extends BaseStepState {
  final List<InstitutionCareer> careers;

  CareerState(this.careers) : super(Step.career.index);
}

class ProgramsState extends BaseStepState {
  final List<InstitutionProgram> programs;

  ProgramsState(this.programs) : super(Step.program.index);
}

class ReviewState extends BaseStepState {
  final CareerEnrollment enrollment;

  ReviewState(this.enrollment) : super(Step.review.index);
}
