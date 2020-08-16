import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/modules/profile/bloc/cubit.dart';
import 'package:universy/modules/profile/header.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/buttons/raised/rounded.dart';
import 'package:universy/widgets/paddings/edge.dart';

class ProfileNotCreateWidget extends StatefulWidget {
  @override
  _ProfileNotCreateState createState() => _ProfileNotCreateState();
}

class _ProfileNotCreateState extends State<ProfileNotCreateWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            alignment: AlignmentDirectional.topCenter,
            child: Column(
              children: <Widget>[
                ProfileHeaderWidget.create(),
                SizedBox(height: 50.0),
                _buildCreateProfileTitle(),
                SizedBox(height: 50.0),
                _buildToCreateProfileButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreateProfileTitle() {
    return SymmetricEdgePaddingWidget.horizontal(
        paddingValue: 15.0,
        child: Text(AppText.getInstance().get("profile.info.profileNotCreated"),
            textAlign: TextAlign.center, style: Theme.of(context).primaryTextTheme.subtitle1));
  }

  Widget _buildToCreateProfileButton(BuildContext context) {
    return CircularRoundedRectangleRaisedButton.general(
      child: AllEdgePaddedWidget(
          padding: 12.0,
          child: Text(AppText.getInstance().get("profile.actions.createProfile"),
              style: Theme.of(context).primaryTextTheme.button)),
      color: Theme.of(context).buttonColor,
      radius: 10,
      onPressed: () => _navigateToCreateProfile(context),
    );
  }

  void _navigateToCreateProfile(BuildContext context) {
    BlocProvider.of<ProfileCubit>(context).toCreate();
  }
}
