import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:optional/optional.dart';
import 'package:universy/model/account.dart';
import 'package:universy/services/exceptions.dart';
import 'package:universy/services/manifest.dart';
import 'package:universy/storage/impl/secure/account.dart';
import 'package:universy/util/logger.dart';
import 'package:universy/util/object.dart';

Map<String, Function> _clientExceptions = {
  "UsernameExistsException": () => UserAlreadyExists(),
};

class DefaultAccountService extends AccountService {
  final CognitoUserPool _userPool;
  static AccountService _instance;

  DefaultAccountService._internal(this._userPool);

  factory DefaultAccountService.instance() {
    if (isNull(_instance)) {
      final userPool = new CognitoUserPool(
          //TODO: Move to config
          "us-east-1_T7vuGy14d",
          "4v8v535v5rh2hkca61k1urun3c",
          storage: SecureAccountStorage.instance());
      _instance = DefaultAccountService._internal(userPool);
    }
    return _instance;
  }

  @override
  Future<void> signUp(User user) async {
    try {
      var data = await _userPool.signUp(
        user.username,
        user.password,
        userAttributes: [],
      );
      Log.getLogger().info(data.toString());
    } on CognitoClientException catch (e) {
      var exceptionType = Optional.ofNullable(_clientExceptions[e.code]) //
          .orElse(() => ServiceException());
      Log.getLogger().warning("User already exists.", e);
      throw exceptionType();
    } catch (e) {
      Log.getLogger().error("Error creating user.", e);
      throw ServiceException();
    }
  }

  @override
  Future<void> confirmAccount(String code) {
    // TODO: implement confirmAccount
    throw UnimplementedError();
  }

  @override
  Future<bool> isLoggedIn() async {
    try {
      var cognitoUser = await _userPool.getCurrentUser();
      var session = await cognitoUser?.getSession();
      return notNull(session) && session.isValid();
    } on CognitoClientException catch (e) {
      Log.getLogger().warning("User not authorized.", e);
      throw NotAuthorized();
    } catch (e) {
      Log.getLogger().error("Error validating login.", e);
      throw ServiceException();
    }
  }

  @override
  Future<void> logIn(User user) async {
    try {
      final cognitoUser = new CognitoUser(
        user.username,
        _userPool,
        storage: SecureAccountStorage.instance(),
      );
      final authDetails = new AuthenticationDetails(
        username: user.username,
        password: user.password,
      );
      await cognitoUser.authenticateUser(authDetails);
    } on CognitoClientException catch (e) {
      Log.getLogger().warning("User not authorized.", e);
      throw NotAuthorized();
    } catch (e) {
      Log.getLogger().error("Error validating login.", e);
      throw ServiceException();
    }
  }

  @override
  void dispose() {
    _instance = null;
  }
}
