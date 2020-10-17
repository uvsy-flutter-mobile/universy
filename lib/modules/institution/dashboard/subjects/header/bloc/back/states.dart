import 'package:universy/model/student/ratings.dart';
import 'package:universy/modules/institution/dashboard/subjects/header/bloc/states.dart';

class StudentRatingFetchedState extends SubjectHeaderState {
  final StudentSubjectRating studentSubjectRating;

  StudentRatingFetchedState(this.studentSubjectRating);
}

class StudentRatingNotFoundState extends SubjectHeaderState {}
