import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:universy/model/account.dart';
import 'package:universy/services/exceptions.dart';
import 'package:universy/services/manifest.dart';
import 'package:universy/util/object.dart';

class DefaultAccountService extends AccountService {
  final CognitoUserPool _userPool;
  static AccountService _instance;

  DefaultAccountService._internal(this._userPool);

/*      var data = await userPool.signUp(
        'saad.gonzalo.ale@gmail.com',
        'Password001',
        userAttributes: [new AttributeArg(name: 'email', value: 'saad.gonzalo.ale@gmail.com')],
      );
      print(data);*/

  factory DefaultAccountService.instance() {
    if (isNull(_instance)) {
      final userPool = new CognitoUserPool(
        //TODO: Move to config
        "us-east-1_T7vuGy14d",
        "4v8v535v5rh2hkca61k1urun3c",
      );
      _instance = DefaultAccountService._internal(userPool);
    }
    return _instance;
  }

  @override
  Future<void> signUp(User user) {
    // TODO: implement signUp
    throw UnimplementedError();
  }

  @override
  Future<void> confirmAccount(String code) {
    // TODO: implement confirmAccount
    throw UnimplementedError();
  }

  @override
  Future<void> logIn(User user) async {
    final cognitoUser = new CognitoUser(user.username, _userPool);
    final authDetails = new AuthenticationDetails(
      username: user.username,
      password: user.password,
    );
    try {
      CognitoUserSession session =
          await cognitoUser.authenticateUser(authDetails);
      print(session.getAccessToken().getJwtToken());
    } on CognitoClientException catch (e) {
      throw NotAuthorized();
    } catch (e) {
      throw ServiceException();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
