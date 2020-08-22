import 'dart:collection';

import 'package:equatable/equatable.dart';
import 'package:universy/model/student/notes.dart';

abstract class NotesState extends Equatable {
  final List<StudentNote> studentNotes;
  final List<StudentNote> displayedNotes;
  final Set<StudentNote> selectedNotes;

  NotesState(this.studentNotes, this.displayedNotes, this.selectedNotes);

  List<Object> get props => [studentNotes, displayedNotes, selectedNotes];
}

class LoadingState extends NotesState {
  LoadingState() : super(List(), List(), HashSet());
}

class FetchedNotesState extends NotesState {
  FetchedNotesState(List<StudentNote> studentNotes)
      : super(studentNotes, studentNotes, HashSet());
}

class UpdatedNotesState extends NotesState {
  UpdatedNotesState(List<StudentNote> studentNotes,
      List<StudentNote> displayableNotes, Set<StudentNote> selectedNotes)
      : super(studentNotes, displayableNotes, selectedNotes);
}
