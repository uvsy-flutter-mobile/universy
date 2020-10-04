import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/constants/routes.dart';
import 'package:universy/model/institution/forum.dart';
import 'package:universy/modules/institution/forum/institution-forum-main.dart';
import 'package:universy/modules/main/bloc/cubit.dart';
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

class CalendarItem extends StatelessWidget {
  const CalendarItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTileItem(
      title: AppText.getInstance().get("main.modules.calendar.title"),
      subtitle: AppText.getInstance().get("main.modules.calendar.subtitle"),
      selected: false,
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, Routes.CALENDAR_MODULE);
      },
    );
  }
}

class StudentNotesItem extends StatelessWidget {
  const StudentNotesItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTileItem(
      title: AppText.getInstance().get("main.modules.notes.title"),
      subtitle: AppText.getInstance().get("main.modules.notes.subtitle"),
      selected: false,
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, Routes.NOTES_MODULE);
      },
    );
  }
}

class ForumItem extends StatelessWidget {
  const ForumItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTileItem(
      title: "Foro",
      //AppText.getInstance().get("main.modules.calendar.title"),
      subtitle: "Revisá tu foro papá!!",
      //AppText.getInstance().get("main.modules.calendar.subtitle"),
      selected: false,
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, Routes.FORUM_MODULE);
      },
    );
  }
}
