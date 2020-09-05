import 'package:universy/apis/errors.dart';
import 'package:universy/apis/students/requests.dart';
import 'package:universy/model/account/profile.dart';
import 'package:universy/services/exceptions/profile.dart';
import 'package:universy/services/exceptions/service.dart';
import 'package:universy/services/manifest.dart';
import 'package:universy/util/logger.dart';
import 'package:universy/util/object.dart';

import 'package:universy/apis/students/api.dart' as studentApi;

import 'account.dart';

class DefaultProfileService extends ProfileService {
  static ProfileService _instance;

  DefaultProfileService._internal();

  factory DefaultProfileService.instance() {
    if (isNull(_instance)) {
      _instance = DefaultProfileService._internal();
    }
    return _instance;
  }

  @override
  void dispose() {
    _instance = null;
  }

  @override
  Future<Profile> getProfile() async {
    try {
      String userId = await DefaultAccountService.instance().getUserId();
      var profile = await studentApi.getProfile(userId);
      return profile.orElseThrow(() => ProfileNotFound());
    } on ServiceException {
      rethrow;
    } on NotFound {
      throw ProfileNotFound();
    } catch (e) {
      Log.getLogger().error(e);
      throw ServiceException();
    }
  }

  @override
  Future<void> updateProfile(Profile profile) async {
    // Here we should put the handling of Conflict when alias is updated!
    try {
      var request = UpdateProfileRequest(
        profile.name,
        profile.lastName,
        profile.alias,
      );
      await studentApi.updateProfile(profile.userId, request);
    } on Conflict {
      throw AliasAlreadyExists();
    } catch (e) {
      Log.getLogger().error(e);
      throw ServiceException();
    }
  }

  Future<void> createProfile(Profile profile) async {
    try {
      await studentApi.createProfile(profile);
    } on Conflict {
      throw AliasAlreadyExists();
    } catch (e) {
      Log.getLogger().error(e);
      throw ServiceException();
    }
  }

  Future<void> checkAliasProfile(Profile profile, String newAlias) async {
    try {
      await studentApi.checkAliasProfile(profile.userId, newAlias);
    } on Conflict {
      throw AliasAlreadyExists();
    } catch (e) {
      Log.getLogger().error(e);
      throw ServiceException();
    }
  }
}
