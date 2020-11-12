import 'package:equatable/equatable.dart';
import 'package:universy/model/account/profile.dart';
import 'package:universy/model/institution/commission.dart';
import 'package:universy/model/institution/forum.dart';
import 'package:universy/model/institution/subject.dart';

abstract class InstitutionForumState extends Equatable {
  InstitutionForumState([List props = const []]) : super();

  @override
  List<Object> get props => [];
}

class LoadingState extends InstitutionForumState {}

class CareerNotCreatedState extends InstitutionForumState {}

class ProfileNotCreatedState extends InstitutionForumState {}

class DisplayState extends InstitutionForumState {
  final List<ForumPublication> forumPublications;
  final List<InstitutionSubject> institutionSubjects;
  final List<Commission> listCommissions;
  final Profile profile;
  final List<String> filters;

  DisplayState(this.forumPublications, this.profile, this.institutionSubjects,this.listCommissions,this.filters);

  Profile get myProfile => profile;

  List<InstitutionSubject> get stateForumSubjects => institutionSubjects;

  List<ForumPublication> get stateForumPublications => forumPublications;
}

class DisplayForumPublicationDetailState extends InstitutionForumState {
  final ForumPublication forumPublication;
  final List<Comment> listComment;
  final Profile profile;

  DisplayForumPublicationDetailState(this.forumPublication, this.profile,this.listComment);
}

class CreateForumPublicationState extends InstitutionForumState {
  final List<InstitutionSubject> institutionSubjects;
  final List<Commission> listCommissions;
  final Profile profile;

  CreateForumPublicationState(this.institutionSubjects, this.profile,this.listCommissions);
}

class UpdateForumPublicationState extends InstitutionForumState {
  final ForumPublication forumPublication;
  final List<InstitutionSubject> institutionSubjects;
  final List<Commission> listCommissions;
  final Profile profile;

  UpdateForumPublicationState(this.institutionSubjects, this.profile,this.forumPublication,this.listCommissions);
}

class ForumPublicationsNotFoundState extends InstitutionForumState {
  final List<ForumPublication> forumPublications;
  final List<InstitutionSubject> institutionSubjects;
  final List<Commission> listCommissions;
  final Profile profile;

  ForumPublicationsNotFoundState(this.forumPublications,this.profile,this.institutionSubjects,this.listCommissions);
}

class FilterForumPublicationsState extends InstitutionForumState {
  final List<InstitutionSubject> institutionSubjects;
  final List<Commission> listCommissions;
  final Profile profile;

  FilterForumPublicationsState(this.institutionSubjects, this.profile,this.listCommissions);
}
