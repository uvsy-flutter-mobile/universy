import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/model/account/profile.dart';
import 'package:universy/model/institution/forum.dart';
import 'package:universy/model/institution/subject.dart';
import 'package:universy/services/manifest.dart';

import 'states.dart';

class InstitutionForumCubit extends Cubit<InstitutionForumState> {
  final StudentCareerService _careerService;
  final InstitutionService _institutionService;
  final ProfileService _profileService;

  InstitutionForumCubit(this._careerService, this._institutionService, this._profileService)
      : super(LoadingState());

  Future<void> fetchPublications() async {
    emit(LoadingState());
    List<ForumPublication> listOfPublications = new List<ForumPublication>();
    List<Comment> list = List<Comment>();
    List<String> listTags = new List<String>();
    Profile profile = Profile("1521515", "Guido", "Henry", "Pepe");
    Comment comment = Comment(1, profile, "La verdad que me parece agradable", DateTime.now());
    list.add(comment);
    list.add(comment);
    list.add(comment);
    list.add(comment);
    listTags.add("MATSUP");
    listTags.add("AM1");
    listTags.add("AM2");
    listTags.add("AM3");
    ForumPublication publication1 = new ForumPublication(1, "Donde curso Diseño?", profile,
        "Tengo una consulta sobre la materia ..ateriaTengo una ..", DateTime.now(), list, listTags);
    ForumPublication publication2 = new ForumPublication(2, "Sorocotongo", profile,
        "Que ondera Superior ? Te rompen el toto ?", DateTime(2014), list, listTags);
    listOfPublications.add(publication1);
    listOfPublications.add(publication2);
    listOfPublications.add(publication2);
    listOfPublications.add(publication2);
    listOfPublications.add(publication2);
    //List<ForumPublication> forumPublications = await _institutionService.getNotes();

    var profile1 = await _profileService.getProfile();

    if (listOfPublications.isNotEmpty) {
      emit(DisplayState(listOfPublications, profile1));
    } else {
      emit(ForumPublicationsNotFoundState());
    }
  }

  void createNewForumPublication() async {
    var programId = await this._careerService.getCurrentProgram();
    var profile = await _profileService.getProfile();
    List<InstitutionSubject> institutionSubjects =
        await this._institutionService.getSubjects(programId);
    emit(CreateForumPublicationState(institutionSubjects, profile));
  }

  void selectForumPublication(ForumPublication forumPublication) async {
    var profile = await _profileService.getProfile();
    emit(DisplayForumPublicationState(forumPublication, profile));
  }

  void filterForumPublications() async {
    var programId = await this._careerService.getCurrentProgram();
    List<InstitutionSubject> institutionSubjects = await this._institutionService.getSubjects(programId);
    emit(FilterForumPublicationsState(institutionSubjects));
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
