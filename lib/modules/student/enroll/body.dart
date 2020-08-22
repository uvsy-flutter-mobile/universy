import 'package:flutter/material.dart';
import 'package:universy/modules/student/enroll/stepper.dart';
import 'package:universy/modules/student/enroll/steps/careers.dart';
import 'package:universy/modules/student/enroll/steps/programs.dart';
import 'package:universy/util/bloc.dart';
import 'package:universy/widgets/progress/circular.dart';

import 'bloc/states.dart';
import 'steps/institutions.dart';
import 'steps/review.dart';

class EnrollBodyBuilder extends WidgetBuilderFactory<EnrollState> {
  @override
  Widget translate(EnrollState state) {
    var progressIndicator = CenterSizedCircularProgressIndicator();

    if (state is BaseStepState) {
      Widget child = progressIndicator;

      if (state is InstitutionState) {
        child = InstitutionStep(institutions: state.institutions);
      } else if (state is CareerState) {
        child = CareerStep(careers: state.careers);
      } else if (state is ProgramsState) {
        child = ProgramStep(programs: state.programs);
      } else if (state is ReviewState) {
        child = ReviewStep(enrollment: state.enrollment);
      }

      return EnrollBodyWidget(step: state.step, child: child);
    }
    return progressIndicator;
  }
}

class EnrollBodyWidget extends StatelessWidget {
  final int step;
  final Widget child;

  const EnrollBodyWidget({Key key, this.step, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(child: EnrollStepper(current: step), flex: 1),
        Expanded(child: child, flex: 9),
      ],
    );
  }
}
