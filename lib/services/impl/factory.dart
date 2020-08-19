import 'package:universy/services/factory.dart';
import 'package:universy/services/impl/general/device.dart';
import 'package:universy/services/impl/student/account.dart';
import 'package:universy/services/impl/student/career.dart';
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
  DeviceService deviceService() {
    return DefaultDeviceService.instance();
  }

  @override
  InstitutionService institutionService() {
    return DefaultInstitutionService.instance();
  }
}
