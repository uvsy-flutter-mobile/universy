import 'package:universy/model/account.dart';

abstract class Service {
  void dispose();
}

abstract class AccountService extends Service {
  Future<bool> isLoggedIn();
  Future<void> logIn(User user);
  Future<void> signUp(User user);
  Future<void> confirmUser(User user, String code);
  Future<void> resendConfirmationCode(User user);
  Future<void> changePassword(User user, String newPassword);
  Future<void> forgotPassword(User user);
  Future<void> confirmPassword(User user, String newPassword);
  Future<void> logOut(User user);
}
