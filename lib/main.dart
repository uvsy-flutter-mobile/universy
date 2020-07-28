import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:universy/services/factory.dart';
import 'package:universy/storage/factory.dart';
import 'package:universy/storage/impl/factory.dart';
import 'package:universy/system/locale.dart';

import 'app/universy.dart';
import 'services/impl/factory.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemLocale.setSystemLocale(SPANISH);
  //await SystemConfig.instance().load();

  // TODO: Should we keep this portrait?

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  var appWithServices = MultiProvider(
    providers: [
      Provider<ServiceFactory>(create: (_) => DefaultServiceFactory.instance()),
      Provider<StorageFactory>(create: (_) => DefaultStorageFactory.instance()),
    ],
    child: Universy(),
  );
  runApp(appWithServices);
}
