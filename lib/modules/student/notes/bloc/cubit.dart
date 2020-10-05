import 'dart:collection';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/model/student/notes.dart';
import 'package:universy/services/manifest.dart';

import 'states.dart';

class NotesCubit extends Cubit<NotesState> {
  final StudentNotesService _notesService;

  NotesCubit(this._notesService) : super(LoadingState());

  Future<void> fetchNotes() async {
    emit(LoadingState());
    List<StudentNote> studentNotes = await _notesService.getNotes();

    if (studentNotes.isNotEmpty) {
      var displayedNotes = List<StudentNote>.of(studentNotes);
      var selectedNotes = HashSet<StudentNote>();
      emit(DisplayNotesState(studentNotes, displayedNotes, selectedNotes));
    } else {
      emit(NotesNotFound());
    }
  }

  void filterNotes(List<StudentNote> filteredNotes) {
    if (state is DisplayNotesState) {
      var displayState = this.state as DisplayNotesState;

      List<StudentNote> studentNotes = displayState.studentNotes;

      List<StudentNote> displayedNotes = List<StudentNote>.of(filteredNotes);

      Set<StudentNote> selectedNotes = displayState.selectedNotes
          .where((note) => filteredNotes.contains(note))
          .toSet();

      emit(DisplayNotesState(studentNotes, displayedNotes, selectedNotes));
    }
  }

  void selectNote(StudentNote note) {
    if (state is DisplayNotesState) {
      var displayState = this.state as DisplayNotesState;

      List<StudentNote> studentNotes = displayState.studentNotes;
      List<StudentNote> displayedNotes = displayState.displayedNotes;
      Set<StudentNote> selectedNotes = HashSet()
        ..addAll(displayState.selectedNotes);

      selectedNotes.add(note);
      emit(DisplayNotesState(studentNotes, displayedNotes, selectedNotes));
    }
  }

  void unselectNote(StudentNote note) {
    if (state is DisplayNotesState) {
      var displayState = this.state as DisplayNotesState;

      List<StudentNote> studentNotes = displayState.studentNotes;
      List<StudentNote> displayedNotes = displayState.displayedNotes;
      Set<StudentNote> selectedNotes = HashSet()
        ..addAll(displayState.selectedNotes);

      selectedNotes.remove(note);

      emit(DisplayNotesState(studentNotes, displayedNotes, selectedNotes));
    }
  }

  void unselectAll() {
    if (state is DisplayNotesState) {
      var displayState = this.state as DisplayNotesState;

      List<StudentNote> studentNotes = displayState.studentNotes;
      List<StudentNote> displayedNotes = displayState.displayedNotes;
      Set<StudentNote> selectedNotes = HashSet();

      emit(DisplayNotesState(studentNotes, displayedNotes, selectedNotes));
    }
  }

  void addNote() {
    emit(AddNoteState());
  }

  void editSelectedNote() {
    if (state is DisplayNotesState) {
      var displayState = this.state as DisplayNotesState;
      var selectedNotes = displayState.selectedNotes;

      if (selectedNotes.length == 1) {
        StudentNote note = selectedNotes.elementAt(0);
        editNote(note);
      }
    }
  }

  void editNote(StudentNote note) {
    emit(EditNoteState(note));
  }

  int amountSelected() {
    if (state is DisplayNotesState) {
      var displayState = this.state as DisplayNotesState;
      return displayState.selectedNotes.length;
    }
    return 0;
  }

  Future<void> createNote(String title, String description) async {
    await _notesService.createNote(title, description);
  }

  Future<void> updateNote(
      String noteId, String title, String description) async {
    await _notesService.updateNote(noteId, title, description);
  }

  Future<void> deleteNote(String noteId) async {
    await _notesService.deleteNote(noteId);
  }

  Future<void> deleteNotes() async {
    if (state is DisplayNotesState) {
      var displayState = this.state as DisplayNotesState;
      var selectedNotes = List.of(displayState.selectedNotes);
      if (selectedNotes.isNotEmpty) {
        await _notesService.batchDeleteNotes(selectedNotes);
      }
    } else if (state is EditNoteState) {
      var displayState = this.state as EditNoteState;
      var deletedNote = displayState.note;
      await _notesService.deleteNote(deletedNote.noteId);
    }
  }
}
