import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/util/bloc.dart';

import 'bloc/cubit.dart';

class MainBodyBuilder extends WidgetBuilderFactory {
  Widget translate(state) {
    throw UnimplementedError();
  }
}

class MainBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<MainCubit>(context);
    return BlocBuilder(
      cubit: cubit,
      builder: MainBodyBuilder().builder(),
    );
  }
}
