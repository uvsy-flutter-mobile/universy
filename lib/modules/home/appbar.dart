import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/util/bloc.dart';

import 'bloc/cubit.dart';

class HomeAppStateBuilder extends WidgetBuilderFactory {
  Widget translate(state) {
    throw UnimplementedError();
  }
}

class HomeAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<HomeCubit>(context);
    return BlocBuilder(
      cubit: cubit,
      builder: HomeAppStateBuilder().builder(),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
