import 'package:equatable/equatable.dart';

abstract class InstitutionSubjectsState extends Equatable {
  InstitutionSubjectsState([List props = const []]) : super();

  @override
  List<Object> get props => [];
}

class LoadingState extends InstitutionSubjectsState {}

class DisplayState extends InstitutionSubjectsState {}

class CareerNotCreatedState extends InstitutionSubjectsState {}
