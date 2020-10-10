import 'package:equatable/equatable.dart';
import 'package:universy/model/account/profile.dart';
import 'package:universy/model/institution/forum.dart';
import 'package:universy/model/institution/subject.dart';

abstract class InstitutionForumState extends Equatable {
  InstitutionForumState([List props = const []]) : super();

  @override
  List<Object> get props => [];
}

class LoadingState extends InstitutionForumState {}

class DisplayState extends InstitutionForumState {
  final List<ForumPublication> forumPublications;
  final Profile profile;

  DisplayState(this.forumPublications,this.profile);

  List<Object> get props => [forumPublications];
}

class DisplayForumPublicationState extends InstitutionForumState {
  final ForumPublication forumPublication;
  final Profile profile;

  DisplayForumPublicationState(this.forumPublication,this.profile);

  List<Object> get props => [forumPublication];
}

class CreateForumPublicationState extends InstitutionForumState {
  final List<InstitutionSubject> institutionSubjects;
  final Profile profile;

  CreateForumPublicationState(this.institutionSubjects,this.profile);

  List<Object> get props => [institutionSubjects];
}

class ForumPublicationsNotFoundState extends InstitutionForumState {}

class FilterForumPublicationsState extends InstitutionForumState {
  final List<InstitutionSubject> institutionSubjects;

  FilterForumPublicationsState(this.institutionSubjects);

}
