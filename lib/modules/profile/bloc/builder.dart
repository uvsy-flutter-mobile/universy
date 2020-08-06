import 'package:flutter/material.dart';
import 'package:universy/modules/profile/display.dart';
import 'package:universy/modules/profile/edit.dart';
import 'package:universy/util/bloc.dart';
import 'package:universy/widgets/progress/circular.dart';

import 'states.dart';

class ProfileStateBuilder extends WidgetBuilderFactory<ProfileState> {
  @override
  Widget translate(ProfileState state) {
    // TODO: Lore, CreateState() needs its own widget
    // Maybe the stepper?
    if (state is DisplayState) {
      return ProfileDisplayWidget(profile: state.profile);
    } else if (state is EditState) {
      return ProfileEditWidget(profile: state.profile);
    }
    return CenterSizedCircularProgressIndicator();
  }
}
