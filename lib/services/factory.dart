import 'manifest.dart';

abstract class ServiceFactory {
  AccountService accountService();

  ProfileService profileService();

  ForumService forumService();

  StudentCareerService studentCareerService();

  StudentEventService studentEventService();

  DeviceService deviceService();

  InstitutionService institutionService();

  StudentNotesService studentNotesService();

  List<Service> services() {
    return [
      accountService(),
      profileService(),
      studentCareerService(),
      studentEventService(),
      institutionService(),
      studentNotesService(),
    ];
  }
}
