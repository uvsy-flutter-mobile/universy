import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/model/account.dart';
import 'package:universy/modules/main/bloc/states.dart';
import 'package:universy/modules/profile/profile.dart';
import 'package:universy/util/bloc.dart';

import 'bloc/cubit.dart';

class MainBodyBuilder extends WidgetBuilderFactory {
  Widget translate(state) {
    if (state is ProfileState) {
      return ProfileModule();
    }
    return Center(
      child: Text("Nada para ver"),
    );
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
