import 'package:flutter/material.dart';
import 'package:universy/modules/main/drawer/header/bloc/states.dart';
import 'package:universy/modules/main/drawer/header/display.dart';
import 'package:universy/util/bloc.dart';
import 'package:universy/widgets/progress/circular.dart';

class MainDrawerBuilder extends WidgetBuilderFactory<HeaderState> {
  Widget translate(HeaderState state) {
    if (state is FetchedInfoState) {
      return MainDrawerHeader(
        currentProgram: state.currentProgram,
        otherPrograms: state.otherPrograms,
      );
    }

    return CenterSizedCircularProgressIndicator();
  }
}
