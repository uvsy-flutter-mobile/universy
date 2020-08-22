import 'package:flutter/material.dart';
import 'package:universy/modules/main/drawer/header/bloc/states.dart';
import 'package:universy/modules/main/drawer/header/main_drawer.dart';
import 'package:universy/modules/main/drawer/header/not_found.dart';
import 'package:universy/util/bloc.dart';
import 'package:universy/widgets/progress/circular.dart';

class MainDrawerBuilder extends WidgetBuilderFactory<HeaderState> {
  Widget translate(HeaderState state) {
    if (state is FetchedInfoState) {
      return MainDrawerHeader(
        currentProgram: state.currentProgram,
        otherPrograms: state.otherPrograms,
      );
    } else if (state is NoCareerState) {
      return NoCareerDrawerHeader();
    }

    return SizedBox(
      height: 100,
      child: CenterSizedCircularProgressIndicator(),
    );
  }
}
