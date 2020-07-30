import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/app/theme.dart';
import 'package:universy/modules/main/bloc/states.dart';
import 'package:universy/text/text.dart';
import 'package:universy/util/bloc.dart';

import 'bloc/cubit.dart';
import 'index.dart';

class MainBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<MainCubit>(context);
    return BlocBuilder(
      cubit: cubit,
      builder: _MainNavigationBarBuilder().builder(),
    );
  }
}

class _MainNavigationBarBuilder extends WidgetBuilderFactory<MainState> {
  Widget translate(MainState state) {
    return _Widget(index: state.index);
  }
}

class _Widget extends StatelessWidget {
  final int index;

  const _Widget({Key key, this.index}) : super(key: key);

  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) => onTabTapped(index, context),
      currentIndex: index,
      items: getNavItems(),
      backgroundColor: uvsyTheme.primaryColor,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.black45,
      iconSize: 27,
    );
  }

  void onTabTapped(int index, BuildContext context) {
    MainCubit cubit = BlocProvider.of<MainCubit>(context);

    if (index == STUDENT_SUBJECT_INDEX) {
      cubit.toStudentSubjects();
    } else if (index == INSTITUTION_SUBJECT_INDEX) {
      cubit.toInstitutionSubjects();
    } else if (index == PROFILE_INDEX) {
      cubit.toProfile();
    }
  }

  List<BottomNavigationBarItem> getNavItems() {
    return [
      BottomNavigationBarItem(
        icon: Icon(Icons.import_contacts),
        title: Text(
          AppText.getInstance().get("main.modules.studentSubjects.title"),
        ),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.account_balance),
        title: Text(
          AppText.getInstance().get("main.modules.institutionSubjects.title"),
        ),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.account_circle),
        title: Text(
          AppText.getInstance().get("main.modules.profile.title"),
        ),
      )
    ];
  }
}
