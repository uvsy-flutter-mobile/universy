import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:universy/modules/student/notes/bloc/builders/body.dart';
import 'package:universy/modules/student/notes/bloc/cubit.dart';
import 'package:universy/services/factory.dart';
import 'package:universy/system/assets.dart';
import 'package:universy/text/text.dart';
import 'package:universy/util/object.dart';
import 'package:universy/widgets/decorations/box.dart';

import 'bloc/builders/buttons.dart';

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
      this._notesCubit.fetchNotes();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocProvider(
        create: (context) => _notesCubit,
        child: Container(
          decoration: assetImageDecoration(Assets.UNIVERSY_CITY_BACKGROUND),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: _buildAppBar(),
            body: _buildBody(),
            floatingActionButton: _buildFloatingActionButton(),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(AppText.getInstance().get("main.modules.notes.title")),
      elevation: 10.0,
      automaticallyImplyLeading: true,
    );
  }

  Widget _buildBody() {
    return BlocBuilder(
      cubit: _notesCubit,
      builder: NotesBodyBuilder().builder(),
    );
  }

  Widget _buildFloatingActionButton() {
    return BlocBuilder(
      cubit: _notesCubit,
      builder: NotesButtonsBuilder().builder(),
    );
  }
}
