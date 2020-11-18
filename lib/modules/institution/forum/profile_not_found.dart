import 'package:flutter/material.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/paddings/edge.dart';

class ProfileNotFoundWidget extends StatefulWidget {
  @override
  _ProfileNotFoundState createState() => _ProfileNotFoundState();
}

class _ProfileNotFoundState extends State<ProfileNotFoundWidget> {
  @override
  Widget build(BuildContext context) {
    return SymmetricEdgePaddingWidget.horizontal(
      paddingValue: 90.0,
      child: Container(
        color: Colors.transparent,
        alignment: AlignmentDirectional.topCenter,
        child: Column(
          children: <Widget>[
            SizedBox(height: 50.0),
            _buildTitle(),
            SizedBox(height: 50.0),
            _buildSubtitle(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      AppText.getInstance()
          .get("institution.forum.profileNotFound.errorMessage"),
      textAlign: TextAlign.center,
      style: Theme.of(context).primaryTextTheme.headline2,
    );
  }

  Widget _buildSubtitle() {
    return Text(
      AppText.getInstance().get("institution.forum.profileNotFound.message"),
      textAlign: TextAlign.center,
      style: Theme.of(context).primaryTextTheme.headline3,
    );
  }
}
