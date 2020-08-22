import 'package:flutter/material.dart';
import 'package:universy/widgets/cards/rectangular.dart';
import 'package:universy/widgets/paddings/edge.dart';

import 'navigation_bar.dart';

class EnrollStep extends StatelessWidget {
  final String title;
  final Widget child;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final String nextLabel;
  final String previousLabel;

  const EnrollStep({
    Key key,
    @required this.title,
    @required this.child,
    @required this.onNext,
    @required this.onPrevious,
    this.nextLabel,
    this.previousLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: _buildBody(context),
      bottomNavigationBar: StepNavigationBar(
        onNext: onNext,
        onPrevious: onPrevious,
        nextLabel: nextLabel,
        previousLabel: previousLabel,
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(child: SizedBox.shrink(), flex: 1),
        Expanded(child: _buildTitle(context), flex: 1),
        Expanded(child: _buildCard(), flex: 8),
        Expanded(child: SizedBox.shrink(), flex: 2)
      ],
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).primaryTextTheme.headline3,
    );
  }

  Widget _buildCard() {
    return AllEdgePaddedWidget(
      padding: 10,
      child: CircularRoundedRectangleCard(
        radius: 18,
        color: Colors.white,
        child: child,
      ),
    );
  }
}
