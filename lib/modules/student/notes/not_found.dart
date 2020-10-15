import 'package:flutter/material.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/paddings/edge.dart';

import 'buttons.dart';

class NotesNotFoundWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: _buildBody(context),
        floatingActionButton: _buildFloatingActionButton(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Center(
      child: Text(
        AppText.getInstance().get("student.notes.info.notesNotFound"),
        style: Theme.of(context).primaryTextTheme.subtitle1,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return OnlyEdgePaddedWidget.bottom(
      child: AddNoteButton(),
      padding: 20,
    );
  }
}
