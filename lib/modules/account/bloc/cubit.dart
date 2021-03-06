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

  Future<void> toRecoverPassword(String user) async {
    emit(RecoverPasswordState(user));
  }

  Future<void> toInputUser() async {
    emit(InputUserState());
  }
}
