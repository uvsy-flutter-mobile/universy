import 'package:universy/model/device.dart';
import 'package:universy/model/institution/institution.dart';
import 'package:universy/model/institution/queries.dart';
import 'package:universy/model/student/account.dart';
import 'package:universy/model/student/career.dart';
import 'package:universy/model/student/session.dart';

/// Base Service
abstract class Service {
  void dispose();
}

/// Student Services
abstract class AccountService extends Service {
  Future<Token> getAuthToken();

  Future<String> getUserId();

  Future<bool> isLoggedIn();

  Future<void> logIn(User user);

  Future<void> signUp(User user);

  Future<void> confirmUser(User user, String code);

  Future<void> resendConfirmationCode(User user);

  Future<void> changePassword(User user, String newPassword);

  Future<void> forgotPassword(User user);

  Future<void> confirmPassword(User user, String newPassword);

  Future<void> logOut();
}

abstract class ProfileService extends Service {
  Future<Profile> getProfile();

  Future<void> updateProfile(Profile profile);

  Future<void> createProfile(Profile profile);

  Future<void> checkAliasProfile(Profile profile, String newAlias);
}

abstract class StudentCareerService extends Service {
  Future<String> getCurrentProgram();

  Future<void> setCurrentProgram(String programId);

  Future<List<StudentCareer>> getCareers();

  Future<StudentCareer> getCareer(String programId);
}

abstract class SessionService extends Service {
  Future<Session> getSession();
}

/// Institution Services
abstract class InstitutionService extends Service {
  Future<List<Institution>> getInstitutions();
  Future<List<InstitutionProgramInfo>> getProgramsInfo(List<String> programIds);
}

/// General Services
abstract class DeviceService extends Service {
  Future<Device> getDevice();
}
