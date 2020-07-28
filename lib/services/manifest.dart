import 'package:universy/model/account.dart';

abstract class Service {
  void dispose();
}

abstract class AccountService extends Service {
  Future<bool> isLoggedIn();
  Future<void> logIn(User user);
  Future<void> signUp(User user);
  Future<void> confirmAccount(String code);
}
