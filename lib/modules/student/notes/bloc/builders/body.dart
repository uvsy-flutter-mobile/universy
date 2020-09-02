import 'package:flutter/material.dart';
import 'package:universy/modules/student/notes/bloc/states.dart';
import 'package:universy/modules/student/notes/display.dart';
import 'package:universy/modules/student/notes/form.dart';
import 'package:universy/modules/student/notes/not_found.dart';
import 'package:universy/util/bloc.dart';
import 'package:universy/widgets/progress/circular.dart';

class NotesBodyBuilder extends WidgetBuilderFactory<NotesState> {
  @override
  Widget translate(NotesState state) {
    if (state is NotesNotFound) {
      return NotesNotFoundWidget();
    } else if (state is AddNoteState) {
      return NoteFormWidget.addNote();
    } else if (state is EditNoteState) {
      return NoteFormWidget.edit(state.note);
    } else if (state is DisplayNotesState) {
      return DisplayNotesWidget(
        notes: state.studentNotes,
        displayableNotes: state.displayedNotes,
        selectedNotes: state.selectedNotes,
      );
    }
    return CenterSizedCircularProgressIndicator();
  }
}
