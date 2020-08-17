import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/system/assets.dart';
import 'package:universy/util/object.dart';
import 'package:universy/widgets/cards/rectangular.dart';
import 'package:universy/widgets/decorations/box.dart';
import 'package:universy/widgets/paddings/edge.dart';

import 'bloc/builder.dart';
import 'bloc/cubit.dart';

class AccountModule extends StatefulWidget {
  @override
  _AccountModuleState createState() => _AccountModuleState();
}

class _AccountModuleState extends State<AccountModule> {
  AccountCubit _accountCubit;

  @override
  void didChangeDependencies() {
    if (isNull(_accountCubit)) {
      this._accountCubit = AccountCubit();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: assetImageDecoration(Assets.UNIVERSY_MAIN_BACKGROUND),
        child: ListView(
          controller: ScrollController(),
          children: <Widget>[
            _LogoWidget(),
            _AccountCard(child: buildAccountContent()),
          ],
        ),
      ),
    );
  }

  Widget buildAccountContent() {
    return BlocProvider(
      create: (context) => _accountCubit,
      child: BlocBuilder(
        cubit: _accountCubit,
        builder: AccountStateBuilder().builder(),
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

class _AccountCard extends StatelessWidget {
  final Widget child;

  const _AccountCard({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
