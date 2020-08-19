import 'package:flutter/material.dart';
import 'package:universy/modules/student/profile/create.dart';
import 'package:universy/modules/student/profile/display.dart';
import 'package:universy/modules/student/profile/form.dart';
import 'package:universy/util/bloc.dart';
import 'package:universy/widgets/progress/circular.dart';

import 'states.dart';

class ProfileStateBuilder extends WidgetBuilderFactory<ProfileState> {
  @override
  Widget translate(ProfileState state) {
    if (state is DisplayState) {
      return ProfileDisplayWidget(profile: state.profile);
    } else if (state is EditState) {
      return ProfileFormWidget.edit(state.profile);
    } else if (state is NotProfileState) {
      return ProfileNotCreateWidget();
    } else if (state is CreateState) {
      return ProfileFormWidget.create(state.userId);
    }
    return CenterSizedCircularProgressIndicator();
  }
}
