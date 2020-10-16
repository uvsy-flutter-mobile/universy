import 'package:equatable/equatable.dart';
import 'package:universy/model/institution/subject.dart';

abstract class InstitutionSubjectsState extends Equatable {
  InstitutionSubjectsState([List props = const []]) : super();

  @override
  List<Object> get props => [];
}

class LoadingState extends InstitutionSubjectsState {}

class DisplayState extends InstitutionSubjectsState {
  final List<InstitutionSubject> subjects;

  DisplayState(this.subjects);
}

class EmptyState extends InstitutionSubjectsState {}

class CareerNotCreatedState extends InstitutionSubjectsState {}
