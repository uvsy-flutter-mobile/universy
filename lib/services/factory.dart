import 'manifest.dart';

abstract class ServiceFactory {
  AccountService accountService();

  ProfileService profileService();

  List<Service> services() {
    return [
      accountService(),
      profileService(),
    ];
  }
}
