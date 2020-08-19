import 'package:flutter/material.dart';
import 'package:universy/modules/student/career/enroll/steps/institutions.dart';
import 'package:universy/util/bloc.dart';

import 'bloc/states.dart';

class EnrollBodyBuilder extends WidgetBuilderFactory<EnrollState> {
  @override
  Widget translate(EnrollState state) {
    return EnrollBodyWidget(current: state.ordinal);
  }
}

class EnrollBodyWidget extends StatelessWidget {
  final int current;

  const EnrollBodyWidget({Key key, this.current}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(primaryColor: Theme.of(context).accentColor),
      child: Stepper(
        controlsBuilder: _controlsBuilder,
        currentStep: current,
        type: StepperType.horizontal,
        steps: _getSteps(),
      ),
    );
  }

  Widget _controlsBuilder(BuildContext context,
      {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
    // The controllers are managed externally
    return SizedBox.shrink();
  }

  List<Step> _getSteps() {
    return [
      _buildStep(ordinal: 0, content: InstitutionStep()),
      _buildStep(ordinal: 1, content: Text("")),
      _buildStep(ordinal: 2, content: Text("")),
      _buildStep(ordinal: 3, content: Text("")),
    ];
  }

  Step _buildStep({int ordinal, Widget content}) {
    var state = StepState.disabled;

    if (current == ordinal) {
      state = StepState.editing;
    } else if (current > ordinal) {
      state = StepState.complete;
    }

    return Step(
        title: Text(""),
        content: content,
        state: state,
        isActive: current >= ordinal);
  }
}
