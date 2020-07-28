import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/util/bloc.dart';

import 'bloc/cubit.dart';

class HomeBodyBuilder extends WidgetBuilderFactory {
  Widget translate(state) {
    throw UnimplementedError();
  }
}

class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<HomeCubit>(context);
    return BlocBuilder(
      cubit: cubit,
      builder: HomeBodyBuilder().builder(),
    );
  }
}
