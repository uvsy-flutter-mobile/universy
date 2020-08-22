import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:optional/optional.dart';
import 'package:universy/constants/strings.dart';
import 'package:universy/model/student/notes.dart';
import 'package:universy/modules/student/notes/bloc/cubit.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/async/modal.dart';
import 'package:universy/widgets/buttons/uvsy/cancel.dart';
import 'package:universy/widgets/buttons/uvsy/save.dart';
import 'package:universy/widgets/flushbar/builder.dart';
import 'package:universy/widgets/paddings/edge.dart';

class FormNoteWidget extends StatefulWidget {
  final StudentNote _note;
  final bool _create;

  const FormNoteWidget._(
      {Key key, @required StudentNote note, @required bool create})
      : this._note = note,
        this._create = create,
        super(key: key);

  @override
  _StudentNewNoteState createState() => _StudentNewNoteState();

  factory FormNoteWidget.create() {
    return FormNoteWidget._(note: StudentNote.empty(), create: true);
  }

  factory FormNoteWidget.edit(StudentNote note) {
    return FormNoteWidget._(note: note, create: false);
  }
}

class _StudentNewNoteState extends State<FormNoteWidget> {
  TextEditingController _titleTextBoxController;
  TextEditingController _descriptionTextBoxController;

  var _cubit;
  StudentNote _note;
  bool _create;

  @override
  void initState() {
    this._note = widget._note;
    this._create = widget._create;
    this._titleTextBoxController = TextEditingController()..text = _note.title;
    this._descriptionTextBoxController = TextEditingController()
      ..text = _note.description;
    this._cubit = BlocProvider.of<NotesCubit>(context);
    super.initState();
  }

  @override
  void dispose() {
    this._titleTextBoxController.dispose();
    this._titleTextBoxController = null;
    this._descriptionTextBoxController.dispose();
    this._descriptionTextBoxController = null;
    this._note = null;
    this._create = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: _create
              ? Text(
                  AppText.getInstance().get("student.notes.info.newNoteTitle"))
              : Text(AppText.getInstance()
                  .get("student.notes.info.updateNoteTitle")),
          centerTitle: false,
          elevation: 6,
          actions: <Widget>[
            _deleteNoteAppBar(context),
          ],
        ),
        body: AllEdgePaddedWidget(
          padding: 10.0,
          child: ListView(
            controller: ScrollController(),
            children: <Widget>[
              _buildStudentTextFields(),
              _buildDatesInformation(),
              _buildButtons(context),
            ],
          ),
        ));
  }

  Widget _buildDatesInformation() {
    if (!_create) {
      DateFormat dateFormat = DateFormat("dd/MM/yyyy hh:mm");
      String date = dateFormat.format(widget._note.updatedAt).toString();
      return Text(
        AppText.getInstance().get("student.notes.info.lastUpdate") +
            date.substring(0, 16),
        style: TextStyle(color: Colors.grey),
        textAlign: TextAlign.right,
      );
    } else {
      return Container();
    }
  }

  Widget _deleteNoteAppBar(BuildContext context) {
    if (_create) {
      return IconButton(
        onPressed: () => _confirmDelete(context),
        icon: Icon(
          Icons.delete,
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _buildStudentTextFields() {
    return StudentTextFieldWidget(
      titleTextBoxController: _titleTextBoxController,
      descriptionTextBoxController: _descriptionTextBoxController,
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        SaveButton(onSave: () => saveNote(context)),
        CancelButton(onCancel: () => Navigator.pop(context)),
      ],
    );
  }

  Future<bool> _confirmDelete(BuildContext context) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          title: Text(AppText.getInstance().get("student.notes.info.atention")),
          content: Text(AppText.getInstance()
              .get("student.notes.actions.confirmDeleteNote")),
          actions: <Widget>[
            SaveButton(onSave: () => _deleteNoteConfirmed(context)),
            CancelButton(onCancel: () => Navigator.of(context).pop(false))
          ],
        );
      },
    );
  }

  void saveNote(BuildContext context) {
    if (_create) {
      _createNewNote(context);
    } else {
      _updateNote(context);
    }
  }

  void _updateNote(BuildContext context) async {
    String title = _fetchTitle();
    String description = _fetchDescription();
    String noteId = widget._note.noteId;

    if (title.isNotEmpty || description.isNotEmpty) {
      await AsyncModalBuilder()
          .perform((_) => _editNote(noteId, title, description, context))
          .then(_navigateToNotes)
          .withTitle(
              AppText.getInstance().get("student.notes.info.updatingNote"))
          .build()
          .run(context);
    } else {
      await _buildErrorMessage();
    }
  }

  void _createNewNote(BuildContext context) async {
    String title = _fetchTitle();
    String description = _fetchDescription();

    if (title.isNotEmpty || description.isNotEmpty) {
      await AsyncModalBuilder()
          .perform((_) => _createNote(title, description, context))
          .then(_navigateToNotes)
          .withTitle(
              AppText.getInstance().get("student.notes.info.creatingNote"))
          .build()
          .run(context);
    } else {
      await _buildErrorMessage();
    }
  }

  Future<void> _deleteNoteConfirmed(BuildContext context) async {
    String noteId = widget._note.noteId;
    await AsyncModalBuilder()
        .perform((_) => _deleteNote(context, noteId))
        .then(_navigateToNotes)
        .withTitle(AppText.getInstance().get("student.notes.info.deletingNote"))
        .build()
        .run(context);
  }

  void _navigateToNotes(BuildContext context) async {
    await _cubit.fetchStudentNotes();
    Navigator.pop(context);
    _buildFlashBarOk(context);
  }

  void _buildFlashBarOk(BuildContext context) {
    FlushBarBroker.success()
        .withMessage(AppText.getInstance().get("student.notes.info.noteSaved"))
        .show(context);
  }

  Future<void> _createNote(
      String title, String description, BuildContext context) async {
    await _cubit.toCreate(title, description);
  }

  Future<void> _editNote(String noteId, String title, String description,
      BuildContext context) async {
    await _cubit.toUpdate(noteId, title, description);
  }

  Future<void> _deleteNote(BuildContext context, String noteId) async {
    await _cubit.toDeleteNote(noteId);
  }

  String _fetchTitle() => Optional.ofNullable(
        _titleTextBoxController.text,
      ).orElse(EMPTY_STRING);

  String _fetchDescription() => Optional.ofNullable(
        _descriptionTextBoxController.text,
      ).orElse(EMPTY_STRING);

  Future<Widget> _buildErrorMessage() {
    return showDialog<Widget>(
      context: context,
      builder: _buildAlertDialog,
    );
  }

  AlertDialog _buildAlertDialog(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
      title: Text(
        AppText.getInstance().get("student.notes.info.atention"),
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Text(
        AppText.getInstance().get("student.notes.input.required"),
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        _buildConfirmButton(context),
      ],
    );
  }
}

Widget _buildConfirmButton(BuildContext context) {
  return FlatButton(
    splashColor: Colors.amber,
    color: Colors.deepPurpleAccent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(30.0)),
    ),
    child: Text(
      AppText.getInstance().get("student.notes.actions.deleteConfirmed"),
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.white),
    ),
    onPressed: () => Navigator.pop(context),
  );
}

class StudentTextFieldWidget extends StatelessWidget {
  final TextEditingController _titleTextBoxController;
  final TextEditingController _descriptionTextBoxController;

  const StudentTextFieldWidget(
      {Key key,
      TextEditingController titleTextBoxController,
      TextEditingController descriptionTextBoxController})
      : this._titleTextBoxController = titleTextBoxController,
        this._descriptionTextBoxController = descriptionTextBoxController,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Row(children: <Widget>[_buildTitleNoteBar()]),
      Row(children: <Widget>[_buildContentNoteBar()]),
    ]);
  }

  Widget _buildContentNoteBar() {
    return Expanded(
      flex: 2,
      child: EdgePaddingWidget(
          EdgeInsets.all(5.0),
          TextField(
            textCapitalization: TextCapitalization.sentences,
            minLines: 12,
            keyboardType: TextInputType.multiline,
            maxLines: 12,
            maxLength: 150,
            controller: _descriptionTextBoxController,
            decoration: _buildContentBarDecoration(),
          )),
    );
  }

  InputDecoration _buildTitleBarDecoration() {
    return InputDecoration(
      counterText: EMPTY_STRING,
      hintText: AppText.getInstance().get("student.notes.input.newTitle"),
    );
  }

  InputDecoration _buildContentBarDecoration() {
    return InputDecoration(
      border: InputBorder.none,
      counterText: EMPTY_STRING,
      hintText: AppText.getInstance().get("student.notes.input.newDescription"),
    );
  }

  Widget _buildTitleNoteBar() {
    return Expanded(
      flex: 2,
      child: EdgePaddingWidget(
        EdgeInsets.all(5.0),
        TextField(
          textCapitalization: TextCapitalization.sentences,
          maxLength: 30,
          controller: _titleTextBoxController,
          decoration: _buildTitleBarDecoration(),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
