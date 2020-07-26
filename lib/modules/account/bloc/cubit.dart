import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'states.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit() : super(LogInState());

  Future<void> toSingUp() async {
    emit(SignUpState());
  }
}
