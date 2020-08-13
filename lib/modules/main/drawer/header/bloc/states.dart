import 'package:equatable/equatable.dart';
import 'package:universy/model/institution/queries.dart';

abstract class HeaderState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadingState extends HeaderState {}

class NoCareerState extends HeaderState {}

class FetchedInfoState extends HeaderState {
  final InstitutionProgramInfo currentProgram;
  final List<InstitutionProgramInfo> otherPrograms;

  FetchedInfoState(this.currentProgram, this.otherPrograms);

  @override
  List<Object> get props => [currentProgram, otherPrograms];
}
