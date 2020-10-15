import 'package:equatable/equatable.dart';
import 'package:universy/model/institution/subject.dart';

class BoardCorrelativesState extends Equatable {
  BoardCorrelativesState([List props = const []]) : super();

  @override
  List<Object> get props => [];
}

class LoadingState extends BoardCorrelativesState {}

class EmptyCorrelativesState extends BoardCorrelativesState {}

class CorrelativesFetchedState extends BoardCorrelativesState {
  final List<CorrelativeItem> correlativesToTake;
  final List<CorrelativeItem> correlativesToApprove;

  CorrelativesFetchedState(this.correlativesToTake, this.correlativesToApprove);
}
