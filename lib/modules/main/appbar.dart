import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:universy/app/theme.dart";
import "package:universy/modules/main/bloc/states.dart";
import "package:universy/text/text.dart";
import "package:universy/util/bloc.dart";

import "bloc/cubit.dart";

class MainAppStateBuilder extends WidgetBuilderFactory<MainState> {
  Widget translate(MainState state) {
    return _Widget(moduleName: state.moduleName);
  }
}

class _Widget extends StatelessWidget {
  final String moduleName;

  const _Widget({Key key, this.moduleName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(AppText.getInstance().get("main.modules.$moduleName.title")),
      backgroundColor: Colors.white,
    );
  }
}

class MainAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<MainCubit>(context);
    return BlocBuilder(
      cubit: cubit,
      builder: MainAppStateBuilder().builder(),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
