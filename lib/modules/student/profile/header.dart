import 'package:flutter/material.dart';
import 'package:universy/model/student/account.dart';
import 'package:universy/system/assets.dart';
import 'package:universy/text/formaters/profile.dart';
import 'package:universy/widgets/decorations/box.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final Widget child;
  ProfileHeaderWidget(this.child);

  factory ProfileHeaderWidget.create() {
    var child = Icon(Icons.priority_high, size: 80, color: Colors.grey);
    return ProfileHeaderWidget(child);
  }
  factory ProfileHeaderWidget.edit(Profile profile) {
    var child = Icon(Icons.more_horiz, size: 80, color: Colors.grey);
    return ProfileHeaderWidget(child);
  }
  factory ProfileHeaderWidget.display(Profile profile) {
    var child = Text(
      InitialsFormatter(profile).format(),
      style: TextStyle(fontSize: 40.0),
    );
    return ProfileHeaderWidget(child);
  }
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
        child: child,
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
