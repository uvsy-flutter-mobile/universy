import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/model/student/account.dart';
import 'package:universy/services/manifest.dart';
import 'package:universy/services/exceptions/profile.dart';

import 'states.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileService _profileService;
  final AccountService _accountService;

  ProfileCubit(this._profileService, this._accountService)
      : super(LoadingState());

  Future<void> toEdit(Profile profile) async {
    emit(EditState(profile));
  }

  Future<void> toDisplay() async {
    emit(LoadingState());
    try {
      var profile = await _profileService.getProfile();
      emit(DisplayState(profile));
    } on ProfileNotFound {
      emit(NotProfileState());
    }
  }

  Future<void> toCreate() async {
    var userId = await _accountService.getUserId();
    emit(CreateState(userId));
  }
}
