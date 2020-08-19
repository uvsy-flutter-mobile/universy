import 'package:equatable/equatable.dart';

abstract class SubjectState extends Equatable {
  SubjectState([List props = const []]) : super();

  @override
  List<Object> get props => [];
}

class LoadingState extends SubjectState {}

class DisplayState extends SubjectState {}

class CareerNotCreatedState extends SubjectState {}
