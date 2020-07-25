import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:universy/app/theme.dart';
import 'package:universy/modules/account/account.dart';
import 'package:universy/system/config.dart';
import 'package:universy/system/locale.dart';

class Universy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [SystemLocale.getSystemLocale()],
      //title: _getApplicationTitle(),
      color: Colors.amber,
      theme: uvsyTheme,
      home: AccountView(),
    );
  }

  String _getApplicationTitle() {
    String stage = SystemConfig.instance().getStage();
    return "Universy [$stage]";
  }
}
