import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optional/optional.dart';
import 'package:universy/constants/strings.dart';
import 'package:universy/model/lock.dart';
import 'package:universy/model/student/notes.dart';
import 'package:universy/modules/student/notes/bloc/cubit.dart';
import 'package:universy/modules/student/notes/note_card.dart';
import 'package:universy/text/text.dart';
import 'package:universy/util/object.dart';
import 'package:universy/widgets/async/modal.dart';
import 'package:universy/widgets/buttons/uvsy/cancel.dart';
import 'package:universy/widgets/buttons/uvsy/save.dart';
import 'package:universy/widgets/paddings/edge.dart';

class NoteFormWidget extends StatefulWidget {
  final StudentNote _note;
  final bool _create;

  const NoteFormWidget._(
      {Key key, @required StudentNote note, @required bool create})
      : this._note = note,
        this._create = create,
        super(key: key);

  @override
  _NoteFormWidgetState createState() => _NoteFormWidgetState();

  factory NoteFormWidget.addNote() {
    return NoteFormWidget._(note: StudentNote.empty(), create: true);
  }

  factory NoteFormWidget.edit(StudentNote note) {
    return NoteFormWidget._(note: note, create: false);
  }
}

class _NoteFormWidgetState extends State<NoteFormWidget> {
  GlobalKey<FormState> _formKeyLog;
  TextEditingController _titleTextBoxController;
  TextEditingController _descriptionTextBoxController;

  NotesCubit _cubit;
  StudentNote _note;
  StateLock<StudentNote> _lock;
  bool _isCreateForm;

  @override
  void didChangeDependencies() {
    if (isNull(_cubit)) {
      this._cubit = BlocProvider.of<NotesCubit>(context);
    }
    super.didChangeDependencies();
  }

  @override
  void initState() {
    this._formKeyLog = GlobalKey<FormState>();
    this._note = widget._note;
    this._lock = StateLock.lock(snapshot: widget._note);
    this._isCreateForm = widget._create;
    this._titleTextBoxController = TextEditingController()..text = _note.title;
    this._descriptionTextBoxController = TextEditingController()
      ..text = _note.description;
    super.initState();
  }

  @override
  void dispose() {
    this._titleTextBoxController.dispose();
    this._titleTextBoxController = null;
    this._descriptionTextBoxController.dispose();
    this._descriptionTextBoxController = null;
    this._note = null;
    this._lock = null;
    this._isCreateForm = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      controller: ScrollController(),
      children: <Widget>[
        Container(
          color: Colors.transparent,
          alignment: AlignmentDirectional.topCenter,
          child: _buildForm(context),
        ),
      ],
    );
  }

  Widget _buildForm(BuildContext context) {
    return SymmetricEdgePaddingWidget.horizontal(
      paddingValue: 75,
      child: Form(
        key: _formKeyLog,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 100),
            NoteCardWidget.form(
              titleController: _titleTextBoxController,
              descriptionController: _descriptionTextBoxController,
            ),
            _buildButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return OnlyEdgePaddedWidget.top(
      padding: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          SaveButton(onSave: save),
          CancelButton(onCancel: cancel),
        ],
      ),
    );
  }

  void save() async {
    if (_formKeyLog.currentState.validate()) {
      if (_isCreateForm) {
        await _create();
      } else {
        this._note.title = _fetchTitle();
        this._note.description = _fetchDescription();
        if (_lock.hasChange(this._note)) {
          await _update();
        }
      }
      await _cubit.fetchNotes();
    }
  }

  Future<void> _create() async {
    String title = _fetchTitle();
    String description = _fetchDescription();

    await AsyncModalBuilder()
        .perform((_) => _createNote(title, description))
        .withTitle(_creatingNoteInfo())
        .build()
        .run(context);
  }

  Future<void> _update() async {
    String title = _fetchTitle();
    String description = _fetchDescription();
    String noteId = widget._note.noteId;

    await AsyncModalBuilder()
        .perform((_) => _updateNote(noteId, title, description))
        .withTitle(_updatingNoteInfo())
        .build()
        .run(context);
  }

  String _creatingNoteInfo() =>
      AppText.getInstance().get("student.notes.info.creatingNote");

  String _updatingNoteInfo() =>
      AppText.getInstance().get("student.notes.info.updatingNote");

  void cancel() {
    _cubit.fetchNotes();
  }

  String _fetchTitle() => Optional.ofNullable(
        _titleTextBoxController.text,
      ).orElse(EMPTY_STRING);

  String _fetchDescription() => Optional.ofNullable(
        _descriptionTextBoxController.text,
      ).orElse(EMPTY_STRING);

  Future<void> _createNote(String title, String description) async {
    await _cubit.createNote(title, description);
  }

  Future<void> _updateNote(
      String noteId, String title, String description) async {
    await _cubit.updateNote(noteId, title, description);
  }
}
