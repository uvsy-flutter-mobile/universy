import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optional/optional.dart';
import 'package:universy/model/student/notes.dart';
import 'package:universy/modules/student/notes/bloc/cubit.dart';
import 'package:universy/modules/student/notes/form.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/paddings/edge.dart';

class NoteCardWidget extends StatelessWidget {
  final bool onSelectionState;
  final StudentNote _note;
  final bool selected;

  const NoteCardWidget(
      {Key key, StudentNote studentNote, this.onSelectionState, this.selected})
      : this._note = studentNote,
        super(key: key);

  Widget build(BuildContext context) {
    return AllEdgePaddedWidget(padding: 5.0, child: _getNoteCard(context));
  }

  Widget _getNoteCard(BuildContext context) {
    return GestureDetector(
      onLongPress: () => _handleLongPress(context),
      onTap: () => _handleTap(context),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: selected ? Colors.amber : Colors.grey,
            width: selected ? 2.0 : 1.0,
          ),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: _buildNoteContent(),
      ),
    );
  }

  Widget _buildNoteContent() {
    return AllEdgePaddedWidget(
        padding: 10.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _buildTitle(),
            SizedBox(height: 10),
            _buildDescription(),
          ],
        ));
  }

  Widget _buildTitle() {
    String title = Optional.ofNullable(_note.title).orElse(_noTitle());
    return Align(
        alignment: Alignment.centerLeft,
        child: AutoSizeText(
          title,
          textAlign: TextAlign.left,
          style: TextStyle(fontWeight: FontWeight.bold),
        ));
  }

  Widget _buildDescription() {
    String description =
        Optional.ofNullable(_note.description).orElse(_noDescription());
    return Align(
        alignment: Alignment.centerLeft,
        child: AutoSizeText(
          description,
          overflow: TextOverflow.clip,
          textAlign: TextAlign.left,
          maxLines: 20,
        ));
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
    BlocProvider.of<NotesCubit>(context).addNoteToSelectedSet(this._note);
  }

  void _deselectStudentNote(BuildContext context) {
    BlocProvider.of<NotesCubit>(context).removeNoteToSelectedSet(this._note);
  }

  void _editStudentNote(BuildContext context) {
    var cubit = BlocProvider.of<NotesCubit>(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider(
            create: (_) => cubit, child: FormNoteWidget.edit(_note)),
      ),
    );
  }

  String _noTitle() =>
      AppText.getInstance().get("student.notes.info.noteWithoutTitle");

  String _noDescription() =>
      AppText.getInstance().get("student.notes.info.noteWithoutDescription");
}
