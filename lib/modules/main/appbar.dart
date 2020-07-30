import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:universy/app/theme.dart";
import "package:universy/modules/main/bloc/states.dart";
import "package:universy/text/text.dart";
import "package:universy/util/bloc.dart";

import "bloc/cubit.dart";

class MainAppStateBuilder extends WidgetBuilderFactory<MainState> {
  Widget translate(MainState state) {
    //return _Widget(index: state.index);
  }
}

class MainAppBarWidget extends StatelessWidget with PreferredSizeWidget {
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
