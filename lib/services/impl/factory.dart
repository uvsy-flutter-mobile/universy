import 'package:universy/services/factory.dart';
import 'package:universy/services/impl/default/account.dart';
import 'package:universy/services/manifest.dart';
import 'package:universy/util/object.dart';

class DefaultServiceFactory extends ServiceFactory {
  static ServiceFactory _instance;

  DefaultServiceFactory._internal();

  factory DefaultServiceFactory.instance() {
    if (isNull(_instance)) {
      _instance = DefaultServiceFactory._internal();
    }
    return _instance;
  }

  @override
  AccountService accountService() {
    return DefaultAccountService.instance();
  }
}
