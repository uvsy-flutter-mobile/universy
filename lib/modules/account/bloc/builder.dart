import 'package:flutter/material.dart';
import 'package:universy/modules/account/inputUser.dart';
import 'package:universy/modules/account/login.dart';
import 'package:universy/modules/account/newPassword.dart';
import 'package:universy/modules/account/recover.dart';
import 'package:universy/modules/account/signup.dart';
import 'package:universy/modules/account/verify.dart';
import 'package:universy/util/bloc.dart';

import 'states.dart';

class AccountStateBuilder extends WidgetBuilderFactory<AccountState> {
  @override
  Widget translate(AccountState state) {
    if (state is SignUpState) {
      return SignUpWidget();
    } else if (state is VerifyState) {
      return VerifyWidget(user: state.user);
    } else if (state is RecoverPasswordState) {
      return RecoverPasswordWidget();
    } else if (state is InputUserState) {
      return InputUserWidget();
    } else if (state is SetNewPasswordState) {
      return SetNewPasswordWidget(user: state.user);
    }

    return LogInWidget();
  }
}
