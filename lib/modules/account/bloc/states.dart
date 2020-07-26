import 'package:equatable/equatable.dart';

abstract class AccountState extends Equatable {
  AccountState([List props = const []]) : super();
}

class LogInState extends AccountState {
  @override
  List<Object> get props => [];
}

class SignUpState extends AccountState {
  @override
  List<Object> get props => [];
}
