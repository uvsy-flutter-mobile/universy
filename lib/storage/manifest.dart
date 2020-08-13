import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:optional/optional.dart';

abstract class AccountStorage extends CognitoStorage {}

abstract class StudentCareerStorage {
  Future<Optional<String>> getCurrentProgram();
  Future<void> setCurrentProgram(String programId);
}
