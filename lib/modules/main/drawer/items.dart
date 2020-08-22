import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/modules/main/bloc/cubit.dart';
import 'package:universy/modules/student/notes/notes.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/tiles/list.dart';

class StudentSubjectsItem extends StatelessWidget {
  final bool _selected;

  const StudentSubjectsItem({Key key, bool selected})
      : this._selected = selected,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTileItem(
      selected: _selected,
      title: AppText.getInstance().get("main.modules.studentSubjects.title"),
      subtitle: AppText.getInstance() //
          .get("main.modules.studentSubjects.subtitle"),
      onTap: () {
        BlocProvider.of<MainCubit>(context).toStudentSubjects();
        Navigator.pop(context);
      },
    );
  }
}

class InstitutionSubjectsItem extends StatelessWidget {
  final bool _selected;

  const InstitutionSubjectsItem({Key key, bool selected})
      : this._selected = selected,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTileItem(
      selected: _selected,
      title: AppText.getInstance() //
          .get("main.modules.institutionSubjects.title"),
      subtitle: AppText.getInstance() //
          .get("main.modules.institutionSubjects.subtitle"),
      onTap: () {
        BlocProvider.of<MainCubit>(context).toInstitutionSubjects();
        Navigator.pop(context);
      },
    );
  }
}

class ProfileItem extends StatelessWidget {
  final bool _selected;

  const ProfileItem({Key key, bool selected})
      : this._selected = selected,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTileItem(
      selected: _selected,
      title: AppText.getInstance().get("main.modules.profile.title"),
      subtitle: AppText.getInstance().get("main.modules.profile.subtitle"),
      onTap: () {
        BlocProvider.of<MainCubit>(context).toProfile();
        Navigator.pop(context);
      },
    );
  }
}

class StudentNotesItem extends StatelessWidget {
  const StudentNotesItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(AppText.getInstance().get("main.modules.notes.title")),
      subtitle: Text(AppText.getInstance().get("main.modules.notes.subtitle")),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => NotesModule()));
      },
    );
  }
}
