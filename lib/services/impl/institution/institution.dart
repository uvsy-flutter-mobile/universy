import 'package:universy/apis/institutions/api.dart' as queryApi;
import 'package:universy/model/institution/queries.dart';
import 'package:universy/services/exceptions/service.dart';
import 'package:universy/services/manifest.dart';
import 'package:universy/util/logger.dart';
import 'package:universy/util/object.dart';

class DefaultInstitutionService implements InstitutionService {
  static InstitutionService _instance;

  DefaultInstitutionService._internal();

  factory DefaultInstitutionService.instance() {
    if (isNull(_instance)) {
      _instance = DefaultInstitutionService._internal();
    }
    return _instance;
  }

  @override
  void dispose() {
    _instance = null;
  }

  @override
  Future<List<InstitutionProgramInfo>> getProgramsInfo(
      List<String> programIds) async {
    try {
      return await queryApi.getProgramsInfo(programIds);
    } on ServiceException catch (e) {
      Log.getLogger().error(e);
      rethrow;
    } catch (e) {
      Log.getLogger().error(e);
      throw ServiceException();
    }
  }
}
