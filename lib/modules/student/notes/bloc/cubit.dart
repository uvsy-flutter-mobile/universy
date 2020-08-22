import 'dart:collection';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/model/student/notes.dart';
import 'package:universy/modules/student/notes/bloc/states.dart';
import 'package:universy/services/exceptions/service.dart';
import 'package:universy/services/manifest.dart';
import 'package:universy/util/logger.dart';

class NotesCubit extends Cubit<NotesState> {
  final StudentNotesService _notesService;

  NotesCubit(this._notesService) : super(LoadingState());

  Future<void> fetchStudentNotes() async {
    try {
      emit(LoadingState());
      List<StudentNote> studentNotes = await _notesService.getNotes();
      emit(FetchedNotesState(studentNotes));
    } catch (e) {
      Log.getLogger().error(e);
      throw ServiceException();
    }
  }

  void filterSelectedNotes(List<StudentNote> filteredNotes) {
    List<StudentNote> studentNotes = state.studentNotes;

    List<StudentNote> displayedNotes = List<StudentNote>.of(filteredNotes);

    Set<StudentNote> selectedNotes = state.selectedNotes
        .where((note) => filteredNotes.contains(note))
        .toSet();

    emit(UpdatedNotesState(studentNotes, displayedNotes, selectedNotes));
  }

  void addNoteToSelectedSet(StudentNote note) {
    List<StudentNote> studentNotes = state.studentNotes;
    List<StudentNote> displayedNotes = state.displayedNotes;
    Set<StudentNote> selectedNotes = HashSet()..addAll(state.selectedNotes);

    selectedNotes.add(note);
    emit(UpdatedNotesState(studentNotes, displayedNotes, selectedNotes));
  }

  void removeNoteToSelectedSet(StudentNote note) {
    List<StudentNote> studentNotes = state.studentNotes;
    List<StudentNote> displayedNotes = state.displayedNotes;
    Set<StudentNote> selectedNotes = HashSet()..addAll(state.selectedNotes);

    selectedNotes.remove(note);

    emit(UpdatedNotesState(studentNotes, displayedNotes, selectedNotes));
  }

  void removeAllSelectedNotes() {
    List<StudentNote> studentNotes = state.studentNotes;
    List<StudentNote> displayedNotes = state.displayedNotes;
    Set<StudentNote> selectedNotes = HashSet();

    emit(UpdatedNotesState(studentNotes, displayedNotes, selectedNotes));
  }

  Future<void> toCreate(String title, String description) async {
    try {
      await _notesService.createNote(title, description);
    } catch (e) {
      Log.getLogger().error(e);
      throw ServiceException();
    }
  }

  Future<void> toUpdate(String noteId, String title, String description) async {
    try {
      await _notesService.updateNote(noteId, title, description);
    } catch (e) {
      Log.getLogger().error(e);
      throw ServiceException();
    }
  }

  Future<void> toDeleteNote(String noteId) async {
    try {
      await _notesService.deleteNote(noteId);
    } catch (e) {
      Log.getLogger().error(e);
    }
  }

  Future<void> toDeleteNotes(List<StudentNote> notes) async {
    try {
      await _notesService.batchDeleteNotes(notes);
    } catch (e) {
      Log.getLogger().error(e);
    }
  }
}
