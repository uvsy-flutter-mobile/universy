import 'package:universy/model/institution/ratings.dart';
import 'package:universy/model/institution/subject.dart';
import 'package:universy/modules/institution/dashboard/subjects/header/bloc/states.dart';

class SubjectRatingFetchedState extends SubjectHeaderState {
  final InstitutionSubject subject;
  final SubjectRating subjectRating;

  SubjectRatingFetchedState(this.subject, this.subjectRating);

  @override
  List<Object> get props => [subject, subjectRating];
}

class EmptySubjectRating extends SubjectHeaderState {
  final InstitutionSubject subject;

  EmptySubjectRating(this.subject);

  @override
  List<Object> get props => [subject];
}

class SubjectRatingNotFound extends SubjectHeaderState {
  final InstitutionSubject subject;

  SubjectRatingNotFound(this.subject);

  @override
  List<Object> get props => [subject];
}
