import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universy/modules/account/account.dart';
import 'package:universy/modules/main/main.dart';
import 'package:universy/services/factory.dart';

class SystemStart {
  static Future<Widget> getWidget(BuildContext context) async {
    var accountService = Provider.of<ServiceFactory>(context).accountService();
    if (await accountService.isLoggedIn()) {
      return MainModule();
    } else {
      return AccountModule();
    }
  }
}
