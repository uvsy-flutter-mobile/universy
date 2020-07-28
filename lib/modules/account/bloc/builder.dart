import 'package:flutter/material.dart';
import 'package:universy/modules/account/login.dart';
import 'package:universy/modules/account/signup.dart';
import 'package:universy/util/bloc.dart';

import 'states.dart';

class AccountStateBuilder extends WidgetBuilderFactory<AccountState> {
  @override
  Widget translate(AccountState state) {
    if (state is SignUpState) {
      return SignUpWidget();
    }
    return LogInWidget();
  }
}
