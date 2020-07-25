import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universy/modules/account/login.dart';
import 'package:universy/system/assets.dart';
import 'package:universy/widgets/cards/rectangular.dart';
import 'package:universy/widgets/decorations/box.dart';
import 'package:universy/widgets/paddings/edge.dart';

class AccountView extends StatefulWidget {
  @override
  _AccountViewState createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: assetImageDecoration(Assets.UNIVERSY_MAIN_BACKGROUND),
      child: ListView(
        children: <Widget>[_LogoWidget(), _AccountWidget()],
      ),
    );
  }
}

class _LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Assets.UNIVERSY_MAIN_LOGO,
      width: MediaQuery.of(context).size.width * 0.20,
      height: MediaQuery.of(context).size.height * 0.20,
    );
  }
}

class _AccountWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AllEdgePaddedWidget(
      padding: 10,
      child: CircularRoundedRectangleCard(
        radius: 18,
        color: Colors.white,
        child: Container(
          //height: MediaQuery.of(context).size.height * 0.40,
          //width: MediaQuery.of(context).size.width * 0.90,
          child: LogInWidget(),
        ),
      ),
    );
  }
}
