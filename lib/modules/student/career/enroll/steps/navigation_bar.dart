import 'package:flutter/material.dart';
import 'package:optional/optional.dart';
import 'package:universy/util/object.dart';
import 'package:universy/widgets/buttons/raised/rounded.dart';
import 'package:universy/widgets/paddings/edge.dart';

class StepNavigationBar extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final String nextLabel;
  final String previousLabel;

  const StepNavigationBar({
    Key key,
    this.onNext,
    this.onPrevious,
    this.nextLabel,
    this.previousLabel,
  }) : super(key: key);

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
    // TODO: Apptext
    var defaultLabel = "Anterior";
    return _buildButton(
      text: Optional.ofNullable(previousLabel).orElse(defaultLabel),
      context: context,
      onPressed: onPrevious,
      enabled: notNull(onPrevious),
    );
  }

  Widget _buildNextButton(BuildContext context) {
    // TODO: Apptext
    var defaultLabel = "Siguiente";
    return _buildButton(
      text: Optional.ofNullable(nextLabel).orElse(defaultLabel),
      context: context,
      onPressed: onNext,
      enabled: notNull(onNext),
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
