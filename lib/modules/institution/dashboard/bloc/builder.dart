import 'package:flutter/material.dart';
import 'package:universy/modules/institution/subjects/display.dart';
import 'package:universy/modules/institution/subjects/not_found.dart';
import 'package:universy/util/bloc.dart';
import 'package:universy/widgets/progress/circular.dart';

import 'states.dart';

class SubjectBoardStateBuilder extends WidgetBuilderFactory<SubjectBoardState> {
  @override
  Widget translate(SubjectBoardState state) {
    return Scaffold(
      body: Container(),
    );
  }
}
