import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/modules/institution/subjects/subjects.dart';
import 'package:universy/modules/main/bloc/states.dart';
import 'package:universy/modules/student/profile/profile.dart';
import 'package:universy/modules/student/subjects/subjects.dart';
import 'package:universy/system/assets.dart';
import 'package:universy/util/bloc.dart';
import 'package:universy/widgets/decorations/box.dart';

import 'bloc/cubit.dart';

class MainBodyBuilder extends WidgetBuilderFactory {
  Widget translate(state) {
    if (state is ProfileState) {
      return ProfileModule();
    } else if (state is StudentSubjectsState) {
      return StudentSubjectsModule();
    } else if (state is InstitutionSubjectsState) {
      return InstitutionSubjectsModule();
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
    return Container(
      decoration: assetImageDecoration(Assets.UNIVERSY_CITY_BACKGROUND),
      child: BlocBuilder(
        cubit: cubit,
        builder: MainBodyBuilder().builder(),
      ),
    );
  }
}
