import 'package:universy/services/factory.dart';
import 'package:universy/services/impl/ratings/ratings.dart';
import 'package:universy/services/impl/forum/forum.dart';
import 'package:universy/services/impl/student/account.dart';
import 'package:universy/services/impl/student/career.dart';
import 'package:universy/services/impl/student/notes.dart';
import 'package:universy/services/impl/student/event.dart';
import 'package:universy/services/impl/student/profile.dart';
import 'package:universy/services/manifest.dart';
import 'package:universy/util/object.dart';

import 'institution/institution.dart';

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

  @override
  ProfileService profileService() {
    return DefaultProfileService.instance();
  }

  @override
  StudentCareerService studentCareerService() {
    return DefaultStudentCareerService.instance();
  }

  @override
  StudentEventService studentEventService() {
    return DefaultStudentEventService.instance();
  }

  @override
  InstitutionService institutionService() {
    return DefaultInstitutionService.instance();
  }

  StudentNotesService studentNotesService() {
    return DefaultStudentNotesService.instance();
  }

  @override
  RatingsService ratingsService() {
    return DefaultRatingsService.instance();
  }

  @override
  ForumService forumService() {
    return DefaultForumService.instance();
  }
}
