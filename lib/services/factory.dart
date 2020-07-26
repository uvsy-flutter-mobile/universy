import 'manifest.dart';

abstract class ServiceFactory {
  AccountService accountService();

  List<Service> services() {
    return [
      accountService(),
    ];
  }
}
