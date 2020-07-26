import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:universy/system/config.dart';
import 'package:universy/system/locale.dart';

import 'app/universy.dart';
import 'services/impl/default/factory.dart';
import 'services/inherited.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemLocale.setSystemLocale(SPANISH);
  //await SystemConfig.instance().load();

  // TODO: Should we keep this portrait?

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  var appWithServices = Services(
    factory: DefaultServiceFactory.instance(),
    child: Universy(),
  );

  runApp(appWithServices);
}
