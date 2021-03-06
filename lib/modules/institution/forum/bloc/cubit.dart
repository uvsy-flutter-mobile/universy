import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/model/account/profile.dart';
import 'package:universy/model/institution/commission.dart';
import 'package:universy/model/institution/forum.dart';
import 'package:universy/model/institution/subject.dart';
import 'package:universy/services/exceptions/student.dart';
import 'package:universy/services/manifest.dart';

import 'states.dart';

class InstitutionForumCubit extends Cubit<InstitutionForumState> {
  final StudentCareerService _careerService;
  final InstitutionService _institutionService;
  final ProfileService _profileService;
  final ForumService _forumService;

  InstitutionForumCubit(
      this._careerService, this._institutionService, this._profileService, this._forumService)
      : super(LoadingState());

  Future<void> fetchPublications(bool isFiltering, List<String> filters) async {
    try {
      emit(LoadingState());
      var profile = await _profileService.getProfile();
      var programId = await this._careerService.getCurrentProgram();
      List<ForumPublication> forumPublications =
          await this._forumService.getForumPublications(programId, 0, profile.userId, filters);
      List<InstitutionSubject> institutionSubjects =
          await this._institutionService.getSubjects(programId);
      List<Commission> listCommissions = await this._institutionService.getCommissions(programId);

      if (forumPublications.isNotEmpty) {
        emit(DisplayState(
            forumPublications, profile, institutionSubjects, listCommissions, filters));
      } else {
        emit(ForumPublicationsNotFoundState(
            forumPublications, profile, institutionSubjects, listCommissions, isFiltering));
      }
    } on CurrentProgramNotFound {
      emit(CareerNotCreatedState());
    } on ProfileNotFound {
      emit(ProfileNotCreatedState());
    }
  }

  void createNewForumPublicationState() async {
    var displayState = this.state as DisplayState;
    emit(CreateForumPublicationState(
        displayState.institutionSubjects, displayState.profile, displayState.listCommissions));
  }

  void createNewForumPublicationFromNotFoundState() async {
    var displayState = this.state as ForumPublicationsNotFoundState;
    emit(CreateForumPublicationState(
        displayState.institutionSubjects, displayState.profile, displayState.listCommissions));
  }

  void viewDetailForumPublicationState(ForumPublication forumPublication) async {
    emit(LoadingState());
    Profile profile = await this._profileService.getProfile();
    List<Comment> listComment = await this
        ._forumService
        .getCommentsPublication(forumPublication.idPublication, profile.userId);
    listComment.sort((a, b) => a.date.compareTo(b.date));
    emit(DisplayForumPublicationDetailState(forumPublication, profile, listComment));
  }

  void updateForumPublicationState(ForumPublication forumPublication) async {
    var displayState = this.state as DisplayState;
    emit(UpdateForumPublicationState(displayState.institutionSubjects, displayState.profile,
        forumPublication, displayState.listCommissions));
  }

  void filterForumPublicationsState() async {
    var displayState = this.state as DisplayState;
    emit(FilterForumPublicationsState(
        displayState.institutionSubjects, displayState.profile, displayState.listCommissions));
  }

  void filterForumPublicationsStateFromNotFound() async {
    var notFoundState = this.state as ForumPublicationsNotFoundState;
    emit(FilterForumPublicationsState(
        notFoundState.institutionSubjects, notFoundState.profile, notFoundState.listCommissions));
  }

  void addForumPublication(String title, String description, List<String> uploadTags) async {
    emit(LoadingState());
    await this._forumService.createForumPublication(title, description, uploadTags);
    fetchPublications(false, []);
  }

  void deleteForumPublication(ForumPublication forumPublication) async {
    emit(LoadingState());
    await this._forumService.deleteForumPublication(forumPublication.idPublication);
    fetchPublications(false, []);
  }

  void updateForumPublication(
      String title, String description, List<String> uploadTags, String idPublication) async {
    emit(LoadingState());
    await this._forumService.updateForumPublication(title, description, uploadTags, idPublication);
    fetchPublications(false, []);
  }

  void deleteComment(Comment comment) async {
    var state = this.state as DisplayForumPublicationDetailState;
    emit(LoadingState());
    await this._forumService.deleteComment(comment.idComment);
    viewDetailForumPublicationState(state.forumPublication);
  }

  void addComment(ForumPublication forumPublication, String userId, String content,
      String idPublication) async {
    emit(LoadingState());
    await this._forumService.createComment(userId, content, idPublication);
    viewDetailForumPublicationState(forumPublication);
  }

  void addVotePublication(
    ForumPublication forumPublication,
    String userId,
  ) {
    this._forumService.addVotePublication(userId, forumPublication.idPublication);
  }

  void reportPublication(ForumPublication forumPublication,String userId,) {
    this._forumService.reportPublication(userId, forumPublication.idPublication);
    fetchPublications(false,[]);
  }

  void reportComment(Comment comment,String userId) async{
    var state = this.state as DisplayForumPublicationDetailState;
    emit(LoadingState());
    await this._forumService.reportComment(userId, comment.idComment);
    viewDetailForumPublicationState(state.forumPublication);
  }

  void addVoteComment(String idComment) async {
    var state = this.state as DisplayForumPublicationDetailState;
    emit(LoadingState());
    await this._forumService.addVoteComment(state.profile.userId, idComment);
    viewDetailForumPublicationState(state.forumPublication);
  }

  void deleteVote(String idVote, bool isPublication) async {
    var state = this.state as DisplayForumPublicationDetailState;
    emit(LoadingState());
    await this._forumService.deleteVote(idVote, isPublication);
    if (!isPublication) {
      fetchPublications(false, []);
    } else {
      viewDetailForumPublicationState(state.forumPublication);
    }
  }

  void deleteVotePublication(String idVote, bool isPublication) {
    this._forumService.deleteVote(idVote, isPublication);
  }
}
