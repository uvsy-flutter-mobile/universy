import 'package:flutter/material.dart';

class EnrollStepper extends StatelessWidget {
  final int current;

  const EnrollStepper({Key key, this.current}) : super(key: key);

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
      _buildStep(ordinal: 0),
      _buildStep(ordinal: 1),
      _buildStep(ordinal: 2),
      _buildStep(ordinal: 3),
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
      content: SizedBox.shrink(),
      state: state,
      isActive: current >= ordinal,
    );
  }
}
