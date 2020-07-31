import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/modules/main/bloc/cubit.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/tiles/lists/dispatcher.dart';

class StudentSubjectsItem extends StatelessWidget {
  final bool _selected;

  const StudentSubjectsItem({Key key, bool selected})
      : this._selected = selected,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return DispatcherListTileItem(
      selected: _selected,
      title: AppText.getInstance().get("main.modules.studentSubjects.title"),
      subtitle: AppText.getInstance() //
          .get("main.modules.studentSubjects.subtitle"),
      eventDispatcher: BlocProvider.of<MainCubit>(context).toStudentSubjects,
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
    return DispatcherListTileItem(
      selected: _selected,
      title:
          AppText.getInstance().get("main.modules.institutionSubjects.title"),
      subtitle: AppText.getInstance()
          .get("main.modules.institutionSubjects.subtitle"),
      eventDispatcher:
          BlocProvider.of<MainCubit>(context).toInstitutionSubjects,
    );
  }
}
