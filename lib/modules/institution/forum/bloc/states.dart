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
  final List<InstitutionSubject> institutionSubjects;
  final Profile profile;

  DisplayState(this.forumPublications, this.profile, this.institutionSubjects);

  Profile get myProfile => profile;

  List<InstitutionSubject> get stateForumSubjects => institutionSubjects;

  List<ForumPublication> get stateForumPublications => forumPublications;
}

class DisplayForumPublicationDetailState extends InstitutionForumState {
  final ForumPublication forumPublication;
  final Profile profile;

  DisplayForumPublicationDetailState(this.forumPublication, this.profile);
}

class CreateForumPublicationState extends InstitutionForumState {
  final List<InstitutionSubject> institutionSubjects;
  final Profile profile;

  CreateForumPublicationState(this.institutionSubjects, this.profile);
}

class UpdateForumPublicationState extends InstitutionForumState {
  final ForumPublication forumPublication;
  final List<InstitutionSubject> institutionSubjects;
  final Profile profile;

  UpdateForumPublicationState(this.institutionSubjects, this.profile,this.forumPublication);
}

class ForumPublicationsNotFoundState extends InstitutionForumState {}

class FilterForumPublicationsState extends InstitutionForumState {
  final List<InstitutionSubject> institutionSubjects;
  final Profile profile;

  FilterForumPublicationsState(this.institutionSubjects, this.profile);
}
