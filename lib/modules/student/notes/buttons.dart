import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/modules/student/notes/bloc/cubit.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/async/modal.dart';
import 'package:universy/widgets/buttons/uvsy/delete.dart';
import 'package:universy/widgets/dialog/confirm.dart';
import 'package:universy/widgets/paddings/edge.dart';

class _NoteButton extends StatelessWidget {
  final String tag;
  final Color color;
  final IconData icon;
  final VoidCallback onPressed;

  const _NoteButton({Key key, this.tag, this.color, this.icon, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: tag,
      backgroundColor: color,
      child: Icon(
        icon,
        size: 30,
      ),
      onPressed: onPressed,
    );
  }
}

class AddNoteButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _NoteButton(
      tag: "addButton",
      color: Colors.deepPurple,
      icon: Icons.note_add,
      onPressed: () => _addNote(context),
    );
  }

  void _addNote(BuildContext context) {
    BlocProvider.of<NotesCubit>(context).addNote();
  }
}

class EditNoteButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _NoteButton(
      tag: "editButton",
      color: Colors.deepPurple,
      icon: Icons.edit,
      onPressed: () => _editStudentNote(context),
    );
  }

  void _editStudentNote(BuildContext context) {
    BlocProvider.of<NotesCubit>(context).editSelectedNote();
  }
}

abstract class DeleteNotesButton extends StatelessWidget {
  Future<void> _onPressedButton(BuildContext context) async {
    bool deleteConfirmed = await _confirmDelete(context);
    if (deleteConfirmed) {
      await AsyncModalBuilder()
          .perform(_deleteStudentNotes)
          .withTitle(_deleteMessage(context))
          .build()
          .run(context);
      await _cubit(context).fetchNotes();
    }
  }

  String _deleteMessage(BuildContext context) {
    if (_cubit(context).amountSelected() > 1) {
      return AppText.getInstance().get("student.notes.info.deletingNotes");
    } else {
      return AppText.getInstance().get("student.notes.info.deletingNote");
    }
  }

  Future<bool> _confirmDelete(BuildContext context) async {
    String textResource = _cubit(context).amountSelected() > 1
        ? "student.notes.actions.confirmDeleteNotes"
        : "student.notes.actions.confirmDeleteNote";
    String content = AppText.getInstance().get(textResource);
    return await showDialog<bool>(
          context: context,
          builder: (context) => ConfirmDialog(
            title: AppText.getInstance().get("student.notes.info.atention"),
            content: content,
          ),
        ) ??
        false;
  }

  Future<void> _deleteStudentNotes(BuildContext context) async {
    await _cubit(context).deleteNotes();
  }

  NotesCubit _cubit(BuildContext context) {
    return BlocProvider.of<NotesCubit>(context);
  }
}

class DeleteFloatingButton extends DeleteNotesButton {
  @override
  Widget build(BuildContext context) {
    return _NoteButton(
      tag: "deleteButton",
      color: Colors.redAccent,
      icon: Icons.delete,
      onPressed: () => _onPressedButton(context),
    );
  }
}

class DeleteIconButton extends DeleteNotesButton {
  @override
  Widget build(BuildContext context) {
    return DeleteButton(
      size: 40.0,
      onDelete: () => _onPressedButton(context),
    );
  }
}

class CancelSelectionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _NoteButton(
      tag: "cancelButton",
      color: Color(0xFf737373),
      icon: Icons.clear,
      onPressed: () => _unselectAll(context),
    );
  }

  void _unselectAll(BuildContext context) {
    BlocProvider.of<NotesCubit>(context).unselectAll();
  }
}

class NotesActionButton extends StatelessWidget {
  final List<Widget> buttons;

  const NotesActionButton._({Key key, this.buttons}) : super(key: key);

  factory NotesActionButton.singleSelect() {
    var buttons = [
      DeleteFloatingButton(),
      SizedBox(height: 15),
      EditNoteButton(),
      SizedBox(height: 15),
      CancelSelectionButton(),
    ];
    return NotesActionButton._(buttons: buttons);
  }

  factory NotesActionButton.multipleSelect() {
    var buttons = [
      DeleteFloatingButton(),
      SizedBox(height: 15),
      CancelSelectionButton(),
    ];
    return NotesActionButton._(buttons: buttons);
  }

  factory NotesActionButton.noSelect() {
    var buttons = [
      AddNoteButton(),
    ];
    return NotesActionButton._(buttons: buttons);
  }

  @override
  Widget build(BuildContext context) {
    return OnlyEdgePaddedWidget.bottom(
      padding: 20,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: buttons,
      ),
    );
  }
}
