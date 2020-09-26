import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:optional/optional.dart';
import 'package:universy/model/account/token.dart';
import 'package:universy/model/account/user.dart';
import 'package:universy/services/exceptions/student.dart';
import 'package:universy/services/exceptions/service.dart';
import 'package:universy/services/manifest.dart';
import 'package:universy/storage/impl/student/account.dart';
import 'package:universy/util/logger.dart';
import 'package:universy/util/object.dart';

Map<String, Function> _clientExceptions = {
  "UsernameExistsException": () => UserAlreadyExists(),
  "CodeMismatchException": () => ConfirmationCodeMismatch(),
  "UserNotFoundException": () => NotAuthorized(),
  "NotAuthorizedException": () => NotAuthorized(),
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

  CognitoUser _createCognitoUser(User user) {
    return CognitoUser(
      user.username,
      _userPool,
      storage: SecureAccountStorage.instance(),
    );
  }

  Exception _translateCognitoClientException(CognitoClientException e) {
    var exceptionType = Optional.ofNullable(_clientExceptions[e.code]) //
        .orElse(() => ServiceException());
    Log.getLogger().warning("Cognito client error.", e);
    return exceptionType();
  }

  @override
  Future<Token> getAuthToken() async {
    // This method assumes the user is already logged in
    // and thus, it has a session available.
    try {
      var cognitoUser = await _userPool.getCurrentUser();
      var session = await cognitoUser?.getSession();
      if (!session.isValid()) {
        session = await cognitoUser.refreshSession(session.refreshToken);
      }
      return Token(
          session.idToken.jwtToken, session.accessToken.jwtToken, session.refreshToken.toString());
    } on CognitoClientException catch (e) {
      throw _translateCognitoClientException(e);
    } catch (e) {
      Log.getLogger().error("Error validating login.", e);
      throw ServiceException();
    }
  }

  @override
  Future<String> getUserId() async {
    try {
      var cognitoUser = await _userPool.getCurrentUser();
      // In the cognito world, the "username" is the userId
      // since the cognito user pool is configured to use
      // email as its main attribute. In this case the "sub" attribute
      // matches the "username" attribute. Which is the key for the account.
      return cognitoUser.getUsername();
    } on CognitoClientException catch (e) {
      throw _translateCognitoClientException(e);
    } catch (e) {
      Log.getLogger().error("Error validating login.", e);
      throw ServiceException();
    }
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
      throw _translateCognitoClientException(e);
    } catch (e) {
      Log.getLogger().error("Error creating user.", e);
      throw ServiceException();
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    try {
      var cognitoUser = await _userPool.getCurrentUser();
      var session = await cognitoUser?.getSession();
      return notNull(session) && session.isValid();
    } on CognitoClientException catch (e) {
      Log.getLogger().warning("Cognito client error.", e);
      return false;
    } catch (e) {
      Log.getLogger().error("Error validating login.", e);
      throw ServiceException();
    }
  }

  @override
  Future<void> logIn(User user) async {
    try {
      final cognitoUser = _createCognitoUser(user);
      final authDetails = AuthenticationDetails(
        username: user.username,
        password: user.password,
      );
      await cognitoUser.authenticateUser(authDetails);
    } on CognitoClientException catch (e) {
      throw _translateCognitoClientException(e);
    } on CognitoUserConfirmationNecessaryException catch (e) {
      Log.getLogger().warning("User is waiting confirmation.", e);
      throw UserNeedsConfirmation();
    } catch (e) {
      Log.getLogger().error("Error validating login.", e);
      throw ServiceException();
    }
  }

  @override
  Future<void> confirmUser(String user, String code) async {
    try {
      final cognitoUser = CognitoUser(user, _userPool);
      await cognitoUser.confirmRegistration(code);
    } on CognitoClientException catch (e) {
      throw _translateCognitoClientException(e);
    } catch (e) {
      Log.getLogger().error("Error confirming user.", e);
      throw ServiceException();
    }
  }

  @override
  Future<void> resendConfirmationCode(String user) async {
    try {
      final cognitoUser = CognitoUser(user, _userPool);
      await cognitoUser.resendConfirmationCode();
    } catch (e) {
      Log.getLogger().error("Error resending code.", e);
      throw ServiceException();
    }
  }

  @override
  Future<void> logOut() async {
    try {
      var cognitoUser = await _userPool.getCurrentUser();
      await cognitoUser.signOut();
    } catch (e) {
      Log.getLogger().error("Error logging out.", e);
      throw ServiceException();
    }
  }

  @override
  Future<void> changePassword(User user, String newPassword) async {
    try {
      final cognitoUser = CognitoUser(user.username, _userPool);
      await cognitoUser.changePassword(
        user.password,
        newPassword,
      );
    } catch (e) {
      Log.getLogger().error("Error changing password.", e);
      throw ServiceException();
    }
  }

  @override
  Future<void> forgotPassword(String user) async {
    try {
      final cognitoUser = CognitoUser(user, _userPool);
      await cognitoUser.forgotPassword();
    } catch (e) {
      Log.getLogger().error("Error recovering password.", e);
      throw ServiceException();
    }
  }

  @override
  Future<void> confirmPassword(User user, String newPassword) async {
    try {
      final cognitoUser = CognitoUser(user.username, _userPool);
      await cognitoUser.confirmPassword(user.password, newPassword);
    } catch (e) {
      Log.getLogger().error("Error confirming password.", e);
      throw ServiceException();
    }
  }

  Future<void> setNewPassword(String user, String newPassword, String code) async {
    bool passwordConfirmed = false;
    final cognitoUser = CognitoUser(user, _userPool);
    try {
      passwordConfirmed = await cognitoUser.confirmPassword(code, newPassword);
    } catch (e) {
      print(e);
    }
    print(passwordConfirmed);
  }

  Future<void> authenticateUser(User user) async {
    try {
      final cognitoUser = CognitoUser(user.username, _userPool);
      final authDetails = AuthenticationDetails(username: user.username,password: user.password,);
      await cognitoUser.authenticateUser(authDetails);
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
