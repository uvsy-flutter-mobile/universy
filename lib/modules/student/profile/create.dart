import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:universy/modules/account/account.dart';
import 'package:universy/services/factory.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/async/modal.dart';
import 'package:universy/widgets/buttons/raised/rounded.dart';
import 'package:universy/widgets/dialog/exit.dart';
import 'package:universy/widgets/paddings/edge.dart';

import 'bloc/cubit.dart';
import 'header.dart';

class ProfileNotCreateWidget extends StatefulWidget {
  @override
  _ProfileNotCreateState createState() => _ProfileNotCreateState();
}

class _ProfileNotCreateState extends State<ProfileNotCreateWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.transparent,
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
      floatingActionButton: _buildExitFloatingButton(context),
    );
  }

  Widget _buildExitFloatingButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.exit_to_app),
      tooltip:
          AppText.getInstance().get("student.profile.actions.closeSession"),
      backgroundColor: Theme.of(context).accentColor,
      onPressed: () => _confirmLogOut(context),
    );
  }

  void _confirmLogOut(BuildContext context) async {
    bool logout = await showDialog(
          context: context,
          builder: (context) => ExitDialog(),
        ) ??
        false;

    if (logout) {
      await AsyncModalBuilder()
          .perform(_logOut)
          .withTitle(
              AppText.getInstance().get("student.profile.info.closingSession"))
          .then(_restartApp)
          .build()
          .run(context);
    }
  }

  Future<void> _logOut(BuildContext context) {
    var accountService =
        Provider.of<ServiceFactory>(context, listen: false).accountService();
    return accountService.logOut();
  }

  void _restartApp(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => AccountModule()));
  }

  Widget _buildCreateProfileTitle() {
    return SymmetricEdgePaddingWidget.horizontal(
        paddingValue: 15.0,
        child: Text(
            AppText.getInstance().get("student.profile.info.profileNotCreated"),
            textAlign: TextAlign.center,
            style: Theme.of(context).primaryTextTheme.subtitle1));
  }

  Widget _buildToCreateProfileButton(BuildContext context) {
    return CircularRoundedRectangleRaisedButton.general(
      child: AllEdgePaddedWidget(
          padding: 12.0,
          child: Text(
              AppText.getInstance()
                  .get("student.profile.actions.createProfile"),
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
