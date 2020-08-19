import 'manifest.dart';

abstract class ServiceFactory {
  AccountService accountService();

  ProfileService profileService();

  StudentCareerService studentCareerService();

  DeviceService deviceService();

  InstitutionService institutionService();

  List<Service> services() {
    return [
      accountService(),
      profileService(),
      studentCareerService(),
      institutionService(),
    ];
  }
}
