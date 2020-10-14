import 'package:equatable/equatable.dart';
import 'package:universy/model/institution/commission.dart';
import 'package:universy/model/institution/couse.dart';
import 'package:universy/model/institution/subject.dart';

class BoardCoursesState extends Equatable {
  BoardCoursesState([List props = const []]) : super();

  @override
  List<Object> get props => [];
}

class LoadingState extends BoardCoursesState {}

class EmptyCoursesState extends BoardCoursesState {}

class CoursesFetchedState extends BoardCoursesState {
  final InstitutionSubject subject;
  final List<Course> courses;
  final Map<String, Commission> commissions;

  CoursesFetchedState(this.subject, this.courses, this.commissions);
}
