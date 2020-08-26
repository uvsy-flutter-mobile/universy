import 'package:equatable/equatable.dart';
import 'package:universy/model/student/notes.dart';

abstract class NotesState extends Equatable {
  List<Object> get props => [];
}

class LoadingState extends NotesState {}

class NotesNotFound extends NotesState {}

class EditNoteState extends NotesState {
  final StudentNote note;

  EditNoteState(this.note);

  List<Object> get props => [note];
}

class AddNoteState extends NotesState {}

class DisplayNotesState extends NotesState {
  final List<StudentNote> studentNotes;
  final List<StudentNote> displayedNotes;
  final Set<StudentNote> selectedNotes;

  DisplayNotesState(this.studentNotes, this.displayedNotes, this.selectedNotes);

  List<Object> get props => [studentNotes, displayedNotes, selectedNotes];
}
