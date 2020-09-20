import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/util/bloc.dart';

import 'bloc/cubit.dart';
import 'bloc/states.dart';
import 'drawer/header/header.dart';
import 'drawer/items.dart';
import 'index.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<MainCubit>(context);
    return BlocBuilder(
      cubit: cubit,
      builder: MainDrawerBarBuilder().builder(),
    );
  }
}

class MainDrawerBarBuilder extends WidgetBuilderFactory<MainState> {
  Widget translate(MainState state) {
    return _Widget(index: state.index);
  }
}

class _Widget extends StatelessWidget {
  final int _index;

  const _Widget({Key key, int index})
      : this._index = index,
        super(key: key);

  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          MainDrawerHeader(),
          Ink(
            child:
                StudentSubjectsItem(selected: _index == STUDENT_SUBJECT_INDEX),
          ),
          Ink(
            child: InstitutionSubjectsItem(
                selected: _index == INSTITUTION_SUBJECT_INDEX),
          ),
          Ink(
            child: ProfileItem(selected: _index == PROFILE_INDEX),
          ),
          Divider(),
          Ink(
            child: CalendarItem(),
          ),
          Ink(
            child: StudentNotesItem(),
          )
        ],
      ),
    );
  }
}
