import 'package:flutter/material.dart';
import 'package:universy/model/student/account.dart';
import 'package:universy/system/assets.dart';
import 'package:universy/text/formaters/profile.dart';
import 'package:universy/widgets/decorations/box.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final Profile _profile;

  ProfileHeaderWidget(this._profile);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              height: 125.0,
              color: Theme.of(context).accentColor,
              child: Container(
                decoration:
                    assetImageDecoration(Assets.UNIVERSY_CLOUDS_HEADER_OPAQUE),
              ),
            ),
            SizedBox(
              height: 55.0,
            ),
          ],
        ),
        Positioned(
          child: _buildCircleAvatar(),
          bottom: 0,
          left: 50,
          right: 50,
        )
      ],
    );
  }

  Widget _buildCircleAvatar() {
    return Container(
      child: CircleAvatar(
        child: Text(
          InitialsFormatter(_profile).format(),
          style: TextStyle(fontSize: 40.0),
        ),
        minRadius: 55,
        backgroundColor: Colors.white,
      ),
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Color(0xfff0f0f0), // border color
        shape: BoxShape.circle,
      ),
    );
  }
}
