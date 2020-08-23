import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:universy/model/student/notes.dart';
import 'package:universy/modules/student/notes/search_bar.dart';
import 'package:universy/widgets/paddings/edge.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optional/optional.dart';
import 'package:universy/modules/student/notes/bloc/cubit.dart';
import 'package:universy/modules/student/notes/note_card.dart';
import 'package:universy/text/text.dart';

class DisplayNotesWidget extends StatelessWidget {
  final List<StudentNote> _notes;
  final List<StudentNote> _displayedNotes;
  final Set<StudentNote> _selectedNotes;

  const DisplayNotesWidget(
      {Key key,
      @required List<StudentNote> notes,
      @required List<StudentNote> displayableNotes,
      @required Set<StudentNote> selectedNotes})
      : this._notes = notes,
        this._displayedNotes = displayableNotes,
        this._selectedNotes = selectedNotes,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(child: _buildSearchTextField(context)),
        Expanded(child: _buildNotesList(), flex: 9)
      ],
    );
  }

  Widget _buildSearchTextField(BuildContext context) {
    return SearchNotesBarWidget(notes: _notes);
  }

  Widget _buildNotesList() {
    return SymmetricEdgePaddingWidget.horizontal(
      paddingValue: 12.0,
      child: StaggeredGridView.countBuilder(
        physics: BouncingScrollPhysics(),
        crossAxisCount: 4,
        itemCount: _displayedNotes.length,
        staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
        mainAxisSpacing: 2.0,
        crossAxisSpacing: 1.5,
        itemBuilder: _noteBuilder,
      ),
    );
  }

  Widget _noteBuilder(BuildContext context, int index) {
    StudentNote studentNote = _displayedNotes[index];
    return _NoteItemWidget(
      studentNote: studentNote,
      onSelectionState: _selectedNotes.isNotEmpty,
      selected: _selectedNotes.contains(studentNote),
    );
  }
}

class _NoteItemWidget extends StatelessWidget {
  final bool onSelectionState;
  final StudentNote _note;
  final bool selected;

  const _NoteItemWidget(
      {Key key, StudentNote studentNote, this.onSelectionState, this.selected})
      : this._note = studentNote,
        super(key: key);

  Widget build(BuildContext context) {
    var padding = selected ? 4.0 : 5.0;
    return AllEdgePaddedWidget(
      padding: padding,
      child: GestureDetector(
        onLongPress: () => _handleLongPress(context),
        onTap: () => _handleTap(context),
        child: NoteCardWidget.display(
          titleText: Optional.ofNullable(_note.title).orElse(_noTitle()),
          descriptionText:
              Optional.ofNullable(_note.description).orElse(_noDescription()),
          selected: selected,
        ),
      ),
    );
  }

  void _handleLongPress(BuildContext context) {
    if (!onSelectionState) {
      _selectStudentNote(context);
    }
  }

  void _handleTap(BuildContext context) {
    if (onSelectionState) {
      if (selected) {
        _deselectStudentNote(context);
      } else {
        _selectStudentNote(context);
      }
    } else {
      _editStudentNote(context);
    }
  }

  void _selectStudentNote(BuildContext context) {
    BlocProvider.of<NotesCubit>(context).selectNote(this._note);
  }

  void _deselectStudentNote(BuildContext context) {
    BlocProvider.of<NotesCubit>(context).unselectNote(this._note);
  }

  void _editStudentNote(BuildContext context) {
    BlocProvider.of<NotesCubit>(context).editNote(this._note);
  }

  String _noTitle() =>
      AppText.getInstance().get("student.notes.info.noteWithoutTitle");

  String _noDescription() =>
      AppText.getInstance().get("student.notes.info.noteWithoutDescription");
}
