import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/model/account/user.dart';

import 'states.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit() : super(LogInState());

  Future<void> toSingUp() async {
    emit(SignUpState());
  }

  Future<void> toLogIn() async {
    emit(LogInState());
  }

  Future<void> toVerify(User user) async {
    emit(VerifyState(user));
  }

  Future<void> toRecoverPassword() async {
    emit(RecoverPasswordState());
  }

  Future<void> toInputUser() async {
    emit(InputUserState());
  }

  Future<void> toSetNewPasswordState(String user) async {
    emit(SetNewPasswordState(user));
  }
}
