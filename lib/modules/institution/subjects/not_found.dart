import 'package:flutter/material.dart';
import 'package:universy/constants/routes.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/buttons/raised/rounded.dart';
import 'package:universy/widgets/paddings/edge.dart';

class CareerNotFoundWidget extends StatefulWidget {
  @override
  _CareerNotFoundState createState() => _CareerNotFoundState();
}

class _CareerNotFoundState extends State<CareerNotFoundWidget> {
  @override
  Widget build(BuildContext context) {
    return SymmetricEdgePaddingWidget.horizontal(
      paddingValue: 90.0,
      child: Container(
        color: Colors.transparent,
        alignment: AlignmentDirectional.topCenter,
        child: Column(
          children: <Widget>[
            SizedBox(height: 125.0),
            _buildTitle(),
            SizedBox(height: 20.0),
            _buildSubtitle(),
            SizedBox(height: 50.0),
            _buildToCreateProfileButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      AppText.getInstance().get("institution.subjects.notFound.title"),
      textAlign: TextAlign.center,
      style: Theme.of(context).primaryTextTheme.headline2,
    );
  }

  Widget _buildSubtitle() {
    return Text(
      AppText.getInstance().get("institution.subjects.notFound.subtitle"),
      textAlign: TextAlign.center,
      style: Theme.of(context).primaryTextTheme.headline3,
    );
  }

  Widget _buildToCreateProfileButton(BuildContext context) {
    return CircularRoundedRectangleRaisedButton.general(
      child: AllEdgePaddedWidget(
        padding: 9.0,
        child: Text(
          AppText.getInstance()
              .get("institution.subjects.notFound.actions.addCareer"),
          style: Theme.of(context).primaryTextTheme.button,
        ),
      ),
      color: Theme.of(context).buttonColor,
      radius: 10,
      onPressed: () => Navigator.pushNamed(context, Routes.CAREER_ENROLL),
    );
  }
}
