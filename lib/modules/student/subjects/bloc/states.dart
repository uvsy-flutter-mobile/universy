import 'package:equatable/equatable.dart';
import 'package:universy/model/subject.dart';

abstract class SubjectState extends Equatable {
  SubjectState([List props = const []]) : super();

  @override
  List<Object> get props => [];
}

class LoadingState extends SubjectState {}

class DisplayState extends SubjectState {
  final List<Subject> subjects;

  DisplayState(this.subjects);
}

class EmptyState extends SubjectState {}

class CareerNotCreatedState extends SubjectState {}
