import 'package:flutter/material.dart';
import 'package:universy/modules/student/notes/bloc/states.dart';
import 'package:universy/modules/student/notes/notes.dart';
import 'package:universy/util/bloc.dart';
import 'package:universy/widgets/progress/circular.dart';

class NotesStateBuilder extends WidgetBuilderFactory<NotesState> {
  @override
  Widget translate(NotesState state) {
    if (state is FetchedNotesState) {
      return NotesBoard(
          notes: state.studentNotes,
          displayableNotes: state.displayedNotes,
          selectedNotes: state.selectedNotes);
    } else if (state is UpdatedNotesState) {
      return NotesBoard(
          notes: state.studentNotes,
          displayableNotes: state.displayedNotes,
          selectedNotes: state.selectedNotes);
    }
    return CenterSizedCircularProgressIndicator();
  }
}
