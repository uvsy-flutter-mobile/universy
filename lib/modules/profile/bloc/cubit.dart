import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/model/student/account.dart';
import 'package:universy/services/manifest.dart';

import 'states.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileService _profileService;

  ProfileCubit(this._profileService) : super(LoadingState());

  Future<void> toEdit(Profile profile) async {
    emit(EditState(profile));
  }

  Future<void> toDisplay() async {
    emit(LoadingState());
    // TODO: Lore, add a try catch on "ProfileNotFound"
    // and emit(CreateState())
    var profile = await _profileService.getProfile();
    emit(DisplayState(profile));
  }
}
