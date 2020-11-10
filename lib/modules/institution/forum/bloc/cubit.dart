import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/model/account/profile.dart';
import 'package:universy/model/institution/commission.dart';
import 'package:universy/model/institution/forum.dart';
import 'package:universy/model/institution/subject.dart';
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

  Future<void> fetchPublications() async {
    emit(LoadingState());
    var profile = await _profileService.getProfile();
    var programId = await this._careerService.getCurrentProgram();
    List<ForumPublication> forumPublications = await this._forumService.getForumPublications(programId,0);
    List<InstitutionSubject> institutionSubjects = await this._institutionService.getSubjects(programId);
    List<Commission> listCommissions = await this._institutionService.getCommissions(programId);

    if (forumPublications.isNotEmpty) {
      emit(DisplayState(forumPublications, profile, institutionSubjects,listCommissions));
    } else {
      emit(ForumPublicationsNotFoundState(forumPublications, profile, institutionSubjects,listCommissions));
    }
  }

  void createNewForumPublicationState() async {
    var displayState = this.state as DisplayState;
    emit(CreateForumPublicationState(displayState.institutionSubjects, displayState.profile,displayState.listCommissions));
  }

  void createNewForumPublicationFromNotFoundState() async {
    var displayState = this.state as ForumPublicationsNotFoundState;
    emit(CreateForumPublicationState(displayState.institutionSubjects, displayState.profile,displayState.listCommissions));
  }

  void viewDetailForumPublicationState(ForumPublication forumPublication) async {
    emit(LoadingState());
    Profile profile = await this._profileService.getProfile();
    List<Comment> listComment = await this._forumService.getCommentsPublication(forumPublication.idPublication);
    emit(DisplayForumPublicationDetailState(forumPublication,profile ,listComment));
  }

  void updateForumPublicationState(ForumPublication forumPublication) async {
    var displayState = this.state as DisplayState;
    emit(UpdateForumPublicationState(
        displayState.institutionSubjects, displayState.profile, forumPublication,displayState.listCommissions));
  }

  void filterForumPublicationsState() async {
    var displayState = this.state as DisplayState;
    emit(FilterForumPublicationsState(displayState.institutionSubjects, displayState.profile,displayState.listCommissions));
  }

  void addForumPublication(String title, String description, List<String> uploadTags) async {
    emit(LoadingState());
    await this._forumService.createForumPublication(title, description, uploadTags);
    fetchPublications();
  }

  void deleteForumPublication(ForumPublication forumPublication) async {
    emit(LoadingState());
    await this._forumService.deleteForumPublication(forumPublication.idPublication);
    fetchPublications();
  }

  void updateForumPublication(String title, String description, List<String> uploadTags, String idPublication) async {
    emit(LoadingState());
    await this._forumService.updateForumPublication(title, description, uploadTags,idPublication);
    fetchPublications();
  }

  void deleteComment(Comment comment) async {
    emit(LoadingState());
    await this._forumService.deleteComment(comment.idComment);
    fetchPublications();
  }

  void addComment(ForumPublication forumPublication,String userId, String content,String idPublication) async {
    emit(LoadingState());
    await this._forumService.createComment(userId, content, idPublication);
    viewDetailForumPublicationState(forumPublication);
  }
}
