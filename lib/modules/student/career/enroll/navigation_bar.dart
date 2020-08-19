import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universy/modules/student/career/enroll/bloc/cubit.dart';
import 'package:universy/util/bloc.dart';
import 'package:universy/widgets/buttons/raised/rounded.dart';
import 'package:universy/widgets/paddings/edge.dart';

import 'bloc/states.dart';

class EnrollNavigationBarBuilder extends WidgetBuilderFactory<EnrollState> {
  @override
  Widget translate(EnrollState state) {
    return EnrollNavigationBar(
      isFinalStep: state.isFinal,
      isInitialStep: state.isInitial,
    );
  }
}

class EnrollNavigationBar extends StatelessWidget {
  final bool isFinalStep;
  final bool isInitialStep;

  const EnrollNavigationBar({Key key, this.isFinalStep, this.isInitialStep})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OnlyEdgePaddedWidget.bottom(
      padding: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(width: 4),
          _buildPreviousButton(context),
          _buildNextButton(context),
          SizedBox(width: 4)
        ],
      ),
    );
  }

  Widget _buildPreviousButton(BuildContext context) {
    return _buildButton(
      text: "Anterior",
      context: context,
      onPressed: () =>
          Provider.of<EnrollCubit>(context, listen: false).previousStep(),
      enabled: !isInitialStep,
    );
  }

  Widget _buildNextButton(BuildContext context) {
    return _buildButton(
      text: "Siguiente",
      context: context,
      onPressed: () =>
          Provider.of<EnrollCubit>(context, listen: false).nextStep(),
      enabled: !isFinalStep,
    );
  }

  Widget _buildButton(
      {String text,
      BuildContext context,
      VoidCallback onPressed,
      bool enabled}) {
    return CircularRoundedRectangleRaisedButton.general(
      child: AllEdgePaddedWidget(
        padding: 12.0,
        child: Text(text, style: Theme.of(context).primaryTextTheme.button),
      ),
      color: Theme.of(context).buttonColor,
      radius: 10,
      onPressed: enabled ? onPressed : null,
    );
  }
}
