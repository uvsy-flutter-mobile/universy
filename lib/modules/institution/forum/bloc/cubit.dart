import 'package:flutter_bloc/flutter_bloc.dart';
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

    print("userId: ${profile.userId}");
    print("programId: ${programId}");

    List<ForumPublication> forumPublications = await this._forumService.getForumPublications(programId,1);
    List<InstitutionSubject> institutionSubjects = await this._institutionService.getSubjects(programId);
    List<Commission> listCommissions = await this._institutionService.getCommissions(programId);

    if (forumPublications.isNotEmpty) {
      emit(DisplayState(forumPublications, profile, institutionSubjects,listCommissions));
    } else {
      emit(ForumPublicationsNotFoundState(forumPublications, profile, institutionSubjects,listCommissions));
    }
  }

  void createNewForumPublication() async {
    var displayState = this.state as DisplayState;
    emit(CreateForumPublicationState(displayState.institutionSubjects, displayState.profile,displayState.listCommissions));
  }

  void createNewForumPublicationFromNotFoundState() async {
    var displayState = this.state as ForumPublicationsNotFoundState;
    emit(CreateForumPublicationState(displayState.institutionSubjects, displayState.profile,displayState.listCommissions));
  }

  void addNewForumPublication(String title, String description, List<String> uploadTags) async {
    emit(LoadingState());
    await this._forumService.createForumPublication(title, description, uploadTags);
    fetchPublications();
  }

  void selectForumPublication(ForumPublication forumPublication) async {
    var displayState = this.state as DisplayState;
    emit(LoadingState());
    List<Comment> listComment = await this._forumService.getCommentsPublication(forumPublication.idPublication);
    emit(DisplayForumPublicationDetailState(forumPublication, displayState.profile,listComment));
  }

  void filterForumPublications() async {
    var displayState = this.state as DisplayState;
    emit(FilterForumPublicationsState(displayState.institutionSubjects, displayState.profile,displayState.listCommissions));
  }

  void updateForumPublication(ForumPublication forumPublication) async {
    var displayState = this.state as DisplayState;
    emit(UpdateForumPublicationState(
        displayState.institutionSubjects, displayState.profile, forumPublication,displayState.listCommissions));
  }

  void deleteForumPublication(ForumPublication forumPublication) async {
    emit(LoadingState());
    await this._forumService.deleteForumPublication(forumPublication.idPublication);
    fetchPublications();
  }

  void deletePublicationComment(Comment comment) async {
    emit(LoadingState());
    await this._forumService.deletePublicationComment(comment.idComment);
    fetchPublications();
  }

  void addNewCommentPublication(ForumPublication forumPublication,String userId, String content,String idPublication) async {
    emit(LoadingState());
    await this._forumService.createCommentPublication(userId, content, idPublication);
    selectForumPublication(forumPublication);
  }


//  void editNote(StudentNote note) {
//   emit(EditNoteState(note));
// }

//  Future<void> createForumPublication(String title, String description) async {
//   await _notesService.createNote(title, description);
//  }

// Future<void> updateForumPublication(String noteId, String title, String description) async {
//  await _notesService.updateNote(noteId, title, description);
// }

// Future<void> deleteForumPublication(String noteId) async {
// await _notesService.deleteNote(noteId);
//}
}
