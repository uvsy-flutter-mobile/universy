import 'package:flutter/material.dart';
import 'package:universy/modules/student/notes/bloc/states.dart';
import 'package:universy/modules/student/notes/buttons.dart';
import 'package:universy/util/bloc.dart';

class NotesButtonsBuilder extends WidgetBuilderFactory<NotesState> {
  @override
  Widget translate(NotesState state) {
    if (state is DisplayNotesState) {
      var selectedNotes = state.selectedNotes;
      if (selectedNotes.isEmpty) {
        return NotesActionButton.noSelect();
      } else if (selectedNotes.length == 1) {
        return NotesActionButton.singleSelect();
      } else {
        return NotesActionButton.multipleSelect();
      }
    }
    return SizedBox.shrink();
  }
}
