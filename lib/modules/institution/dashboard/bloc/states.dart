import 'package:equatable/equatable.dart';

abstract class SubjectBoardState extends Equatable {
  SubjectBoardState([List props = const []]) : super();

  @override
  List<Object> get props => [];
}

class LoadingState extends SubjectBoardState {}

class DisplayState extends SubjectBoardState {}
