import 'manifest.dart';

abstract class ServiceFactory {
  AccountService accountService();

  ProfileService profileService();

  StudentCareerService studentCareerService();

  RatingsService ratingsService();

  StudentEventService studentEventService();

  InstitutionService institutionService();

  StudentNotesService studentNotesService();

  List<Service> services() {
    return [
      accountService(),
      profileService(),
      studentCareerService(),
      ratingsService(),
      studentEventService(),
      institutionService(),
      studentNotesService(),
    ];
  }
}
