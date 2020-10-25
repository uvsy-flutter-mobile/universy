import 'package:flutter/material.dart';
import 'package:universy/widgets/paddings/edge.dart';

class _ScheduleButton extends StatelessWidget {
  final String tag;
  final Color color;
  final IconData icon;
  final VoidCallback onPressed;

  const _ScheduleButton(
      {Key key, this.tag, this.color, this.icon, this.onPressed})
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

class SaveScratchButton extends StatelessWidget {
  Widget build(BuildContext context) {
    return _ScheduleButton(
      tag: "saveButton",
      color: Colors.deepPurple,
      icon: Icons.check,
      /*onPressed: () => _saveScratch(context),*/
      onPressed: () => {},
    );
  }

  void _saveScratch(BuildContext context) {
    /*onPressed: () =>   BlocProvider.of<NotesCubit>(context).createScratch();*/
  }
}

class AddScheduleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _ScheduleButton(
      tag: "addButton",
      color: Colors.amber,
      icon: Icons.add,
      /*onPressed: () => _editScratch(context),*/
      onPressed: () => {},
    );
  }

  void _editScratch(BuildContext context) {
    /*BlocProvider.of<NotesCubit>(context).editScratch();*/
  }
}

/*
abstract class DeleteScratchButton extends StatelessWidget {
  Future<void> _onPressedButton(BuildContext context) async {
    bool deleteConfirmed = await _confirmDelete(context);
    if (deleteConfirmed) {
      await AsyncModalBuilder()
          .perform(_deleteScratch)
          .withTitle(_deleteMessage(context))
          .build()
          .run(context);
      await _cubit(context).fetchScratches();
    }
  }

  String _deleteMessage(BuildContext context) {
    return "Eliminando el horario";
  }

  Future<bool> _confirmDelete(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) => ScheduleConfirmMessage(
        scheduleName: "Atencion",
        alertMessage: "¿Seguro que desea eliminar?",
        confirmMessage: "Eliminar",
      ),
    ) ??
        false;
  }

  Future<void> _deleteScratch(BuildContext context) async {
    /*await _cubit(context).deleteScratch();*/
  }

  ScheduleCubit _cubit(BuildContext context) {
    return BlocProvider.of<ScheduleCubit>(context);
  }
}*/

class ViewScheduleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _ScheduleButton(
      tag: "viewButton",
      color: Colors.amber,
      icon: Icons.calendar_today,
      onPressed: () => {},
    );
  }

  void _unselectAll(BuildContext context) {
    /*BlocProvider.of<ScheduleCubit>(context).viewSchedule(studentScheduleScratch);*/
  }
}

class ScheduleActionButton extends StatelessWidget {
  final List<Widget> buttons;

  const ScheduleActionButton._({Key key, this.buttons}) : super(key: key);

  factory ScheduleActionButton.create() {
    var buttons = [
      AddScheduleButton(),
      SizedBox(height: 15),
      SaveScratchButton(),
    ];
    return ScheduleActionButton._(buttons: buttons);
  }

  factory ScheduleActionButton.edit() {
    var buttons = [
      AddScheduleButton(),
      SizedBox(height: 15),
      ViewScheduleButton(),
      SizedBox(height: 15),
      SaveScratchButton(),
    ];
    return ScheduleActionButton._(buttons: buttons);
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