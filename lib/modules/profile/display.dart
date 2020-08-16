import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:universy/model/student/account.dart';
import 'package:universy/modules/account/account.dart';
import 'package:universy/modules/profile/bloc/cubit.dart';
import 'package:universy/services/factory.dart';
import 'package:universy/text/formaters/profile.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/async/modal.dart';
import 'package:universy/widgets/builder/builder.dart';
import 'package:universy/widgets/dialog/exit.dart';

import 'header.dart';

class ProfileDisplayWidget extends StatelessWidget {
  final Profile profile;

  const ProfileDisplayWidget({Key key, this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  Widget _buildBody() {
    return Container(
      alignment: AlignmentDirectional.topCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ProfileHeaderWidget.display(this.profile),
          SizedBox(height: 15),
          _buildNameAndLastName(),
          SizedBox(height: 5),
          _buildAlias(),
          SizedBox(height: 10),
          Divider(color: Colors.black12),
          SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildNameAndLastName() {
    return _buildFormattedText(
      text: CompleteNameFormatter(profile).format(),
    );
  }

  Widget _buildAlias() {
    return _buildFormattedText(
      text: AliasFormatter(profile).format(),
      fontWeight: FontWeight.normal,
    );
  }

  Widget _buildFormattedText(
      {String text, FontWeight fontWeight = FontWeight.bold}) {
    return Text(
      text,
      style:
          TextStyle(letterSpacing: 0.5, fontSize: 20, fontWeight: fontWeight),
      textAlign: TextAlign.end,
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return SpeedDial(
      shape: CircleBorder(),
      heroTag: "profile_tooltip_hero_tag",
      animatedIcon: AnimatedIcons.menu_close,
      backgroundColor: Theme.of(context).primaryColor,
      children: [
        _EditDialBuilder(() => _navigateToEdit(context)).build(context),
        _ExitDialBuilder().build(context),
      ],
    );
  }

  void _navigateToEdit(BuildContext context) {
    context.read<ProfileCubit>().toEdit(this.profile);
  }
}

class _EditDialBuilder extends ComponentBuilder<SpeedDialChild> {
  final VoidCallback editAction;

  _EditDialBuilder(this.editAction);

  @override
  SpeedDialChild build(BuildContext context) {
    return SpeedDialChild(
      child: Icon(Icons.edit),
      backgroundColor: Theme.of(context).accentColor,
      label: AppText.getInstance().get("profile.actions.edit"),
      labelStyle: TextStyle(fontSize: 18.0),
      onTap: editAction,
    );
  }
}

class _ExitDialBuilder extends ComponentBuilder<SpeedDialChild> {
  @override
  SpeedDialChild build(BuildContext context) {
    return SpeedDialChild(
      child: Icon(Icons.exit_to_app),
      backgroundColor: Theme.of(context).accentColor,
      label: AppText.getInstance().get("profile.actions.closeSession"),
      labelStyle: TextStyle(fontSize: 18.0),
      onTap: () => _confirmLogOut(context),
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
          .withTitle(AppText.getInstance().get("profile.info.closingSession"))
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
}
