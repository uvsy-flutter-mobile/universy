import 'package:flutter/material.dart';
import 'package:universy/constants/routes.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/buttons/raised/rounded.dart';
import 'package:universy/widgets/paddings/edge.dart';

class NoCareerDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AllEdgePaddedWidget(
      padding: 10,
      child: Container(
        color: Colors.transparent,
        alignment: AlignmentDirectional.topCenter,
        child: Column(
          children: <Widget>[
            SizedBox(height: 2.0),
            _buildTitle(context),
            SizedBox(height: 20.0),
            _buildToCreateProfileButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      AppText.getInstance().get("main.drawer.notFound.title"),
      textAlign: TextAlign.center,
      style: Theme.of(context).primaryTextTheme.headline6,
    );
  }

  Widget _buildToCreateProfileButton(BuildContext context) {
    return CircularRoundedRectangleRaisedButton.general(
      child: AllEdgePaddedWidget(
        padding: 12.0,
        child: Text(
          AppText.getInstance().get("main.drawer.notFound.actions.addCareer"),
          style: Theme.of(context).primaryTextTheme.button,
        ),
      ),
      color: Theme.of(context).buttonColor,
      radius: 10,
      onPressed: () => Navigator.pushNamed(context, Routes.CAREER_ENROLL),
    );
  }
}
