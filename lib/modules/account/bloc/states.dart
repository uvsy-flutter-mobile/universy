import 'package:equatable/equatable.dart';
import 'package:universy/model/student/account.dart';

abstract class AccountState extends Equatable {
  AccountState([List props = const []]) : super();

  @override
  List<Object> get props => [];
}

class LogInState extends AccountState {}

class SignUpState extends AccountState {}

class VerifyState extends AccountState {
  final User user;

  VerifyState(this.user);

  @override
  List<Object> get props => [user.hashCode];
}
