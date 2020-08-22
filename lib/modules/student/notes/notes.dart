import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:universy/model/student/notes.dart';
import 'package:universy/modules/student/notes/bloc/builder.dart';
import 'package:universy/modules/student/notes/bloc/cubit.dart';
import 'package:universy/modules/student/notes/form.dart';
import 'package:universy/modules/student/notes/notes_card.dart';
import 'package:universy/modules/student/notes/search_bar.dart';
import 'package:universy/services/factory.dart';
import 'package:universy/system/assets.dart';
import 'package:universy/text/text.dart';
import 'package:universy/util/object.dart';
import 'package:universy/widgets/async/modal.dart';
import 'package:universy/widgets/buttons/uvsy/cancel.dart';
import 'package:universy/widgets/buttons/uvsy/save.dart';
import 'package:universy/widgets/decorations/box.dart';
import 'package:universy/widgets/paddings/edge.dart';

class NotesModule extends StatefulWidget {
  _NotesModuleState createState() => _NotesModuleState();
}

class _NotesModuleState extends State<NotesModule> {
  NotesCubit _notesCubit;

  @override
  void didChangeDependencies() {
    if (isNull(_notesCubit)) {
      var sessionFactory = Provider.of<ServiceFactory>(context, listen: false);
      var studentNoteService = sessionFactory.studentNotesService();
      this._notesCubit = NotesCubit(studentNoteService);
      this._notesCubit.fetchStudentNotes();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _notesCubit,
      child: Scaffold(
        appBar: _buildAppBar(),
        body: BlocBuilder(
          cubit: _notesCubit,
          builder: NotesStateBuilder().builder(),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: false,
      title: Text(AppText.getInstance().get("main.modules.notes.title")),
      elevation: 10.0,
      automaticallyImplyLeading: true,
      backgroundColor: Colors.white,
    );
  }
}

class NotesBoard extends StatelessWidget {
  final List<StudentNote> _notes;
  final List<StudentNote> _displayedNotes;
  final Set<StudentNote> _selectedNotes;

  const NotesBoard(
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
    return Container(
      decoration: assetImageDecoration(Assets.UNIVERSY_CITY_BACKGROUND),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(child: _buildSearchTextField(context)),
            Expanded(child: _buildBoardContent(context), flex: 9)
          ],
        ),
        floatingActionButton: _buildFloatingActionButton(context),
      ),
    );
  }

  Widget _buildSearchTextField(BuildContext context) {
    return SearchNotesBarWidget(notes: _notes);
  }

  Widget _buildBoardContent(BuildContext context) {
    if (_displayedNotes.isNotEmpty) {
      return _buildNotesList();
    } else {
      return _buildNotesNotFoundMessage(context);
    }
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return OnlyEdgePaddedWidget.bottom(
      child: _selectedNotes.isNotEmpty
          ? _buildNoteActionButtons(context)
          : AddNoteButton(),
      padding: 20,
    );
  }

  Widget _buildNoteActionButtons(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        _buildNotesCancelButton(context),
        SizedBox(height: 15),
        NotesDeleteButton(studentNotes: _selectedNotes),
        SizedBox(height: 15),
        _buildNotesEditButton(context),
      ],
    );
  }

  Widget _buildNotesEditButton(BuildContext context) {
    if (_selectedNotes.length > 1) {
      return SizedBox(height: 15);
    } else {
      return FloatingActionButton(
        heroTag: "edit-button",
        backgroundColor: Colors.deepPurple,
        child: Icon(
          Icons.edit,
          size: 30,
        ),
        onPressed: () => _editStudentNote(context),
      );
    }
  }

  void _editStudentNote(BuildContext context) {
    var cubit = BlocProvider.of<NotesCubit>(context);
    StudentNote note = _selectedNotes.elementAt(0);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider(
            create: (_) => cubit, child: FormNoteWidget.edit(note)),
      ),
    );
  }

  Widget _buildNotesCancelButton(BuildContext context) {
    return FloatingActionButton(
      heroTag: "cancel-button",
      backgroundColor: Color(0xFf737373),
      child: Icon(
        Icons.clear,
        size: 30,
      ),
      onPressed: () => _deselectAllStudentEvents(context),
    );
  }

  void _deselectAllStudentEvents(BuildContext context) {
    BlocProvider.of<NotesCubit>(context).removeAllSelectedNotes();
  }

  Widget _buildNotesNotFoundMessage(BuildContext context) {
    return Center(
        child: Text(
            AppText.getInstance().get("student.notes.info.notesNotFound"),
            style: Theme.of(context).primaryTextTheme.subtitle1,
            textAlign: TextAlign.center));
  }

  Widget _buildNotesList() {
    return SymmetricEdgePaddingWidget.horizontal(
        paddingValue: 12.0,
        child: StaggeredGridView.countBuilder(
          crossAxisCount: 4,
          itemCount: _displayedNotes.length,
          staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
          mainAxisSpacing: 2.0,
          crossAxisSpacing: 0.5,
          itemBuilder: (BuildContext context, int index) {
            StudentNote studentNote = _displayedNotes[index];
            return _buildStudentNoteCardWidget(studentNote, index);
          },
        ));
  }

  Widget _buildStudentNoteCardWidget(StudentNote studentNote, index) {
    return NoteCardWidget(
      studentNote: studentNote,
      onSelectionState: _selectedNotes.isNotEmpty,
      selected: _selectedNotes.contains(studentNote),
    );
  }
}

class AddNoteButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FloatingActionButton(
        heroTag: "addButton",
        backgroundColor: Colors.deepPurple,
        child: Icon(
          Icons.note_add,
          size: 30,
        ),
        onPressed: () => _navigateNotNewStudentNote(context),
      ),
    );
  }

  void _navigateNotNewStudentNote(BuildContext context) {
    var cubit = BlocProvider.of<NotesCubit>(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            BlocProvider(create: (_) => cubit, child: FormNoteWidget.create()),
      ),
    );
  }
}

class NotesDeleteButton extends StatelessWidget {
  final Set<StudentNote> studentNotes;

  const NotesDeleteButton({Key key, this.studentNotes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.redAccent,
      child: Icon(
        Icons.delete,
        size: 30,
      ),
      onPressed: () => _onPressedButton(context),
    );
  }

  Future<void> _onPressedButton(BuildContext context) async {
    bool deleteConfirmed = await _confirmDeletion(context);
    if (deleteConfirmed) {
      await AsyncModalBuilder()
          .perform(_deleteStudentNote)
          .withTitle(_deleteMessage())
          .then(_dispatchStudentNotesDeleted)
          .build()
          .run(context);
    }
  }

  Future<void> _deleteStudentNote(BuildContext context) async {
    List<StudentNote> notesToDelete = studentNotes.toList();
    await BlocProvider.of<NotesCubit>(context).toDeleteNotes(notesToDelete);
  }

  String _deleteMessage() {
    if (studentNotes.length > 1) {
      return AppText.getInstance().get("student.notes.info.deletingNotes");
    } else {
      return AppText.getInstance().get("student.notes.info.deletingNote");
    }
  }

  void _dispatchStudentNotesDeleted(BuildContext context) {
    BlocProvider.of<NotesCubit>(context).fetchStudentNotes();
  }

  Future<bool> _confirmDeletion(BuildContext context) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          title: Text(AppText.getInstance().get("student.notes.info.atention")),
          content: studentNotes.length > 1
              ? Text(AppText.getInstance()
                  .get("student.notes.actions.confirmDeleteNotes"))
              : Text(AppText.getInstance()
                  .get("student.notes.actions.confirmDeleteNote")),
          actions: <Widget>[
            SaveButton(onSave: () => Navigator.of(context).pop(true)),
            CancelButton(onCancel: () => Navigator.of(context).pop(false))
          ],
        );
      },
    );
  }
}
