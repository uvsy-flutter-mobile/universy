import 'package:equatable/equatable.dart';
import 'package:universy/model/institution/ratings.dart';

abstract class CourseRatingState extends Equatable {
  @override
  List<Object> get props => [];
}

class CourseRatingInitialState extends CourseRatingState {}

class CourseRatingReceivedState extends CourseRatingState {
  final CourseRating courseRating;

  CourseRatingReceivedState(this.courseRating);

  @override
  List<Object> get props => [courseRating];
}

class CourseRatingNotExistingState extends CourseRatingState {}
