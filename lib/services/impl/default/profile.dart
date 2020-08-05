import 'package:universy/apis/errors.dart';
import 'package:universy/model/account.dart';
import 'package:universy/services/exceptions/profile.dart';
import 'package:universy/services/exceptions/service.dart';
import 'package:universy/services/impl/default/account.dart';
import 'package:universy/services/manifest.dart';
import 'package:universy/util/logger.dart';
import 'package:universy/util/object.dart';

import 'package:universy/apis/students/profile.dart' as profileApi;

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
      var profile = await profileApi.getProfile(userId);
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
}
