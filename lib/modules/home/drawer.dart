import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/util/bloc.dart';

import 'bloc/cubit.dart';

class HomeDrawerBarBuilder extends WidgetBuilderFactory {
  Widget translate(state) {
    throw UnimplementedError();
  }
}

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<HomeCubit>(context);
    return BlocBuilder(
      cubit: cubit,
      builder: HomeDrawerBarBuilder().builder(),
    );
  }
}
