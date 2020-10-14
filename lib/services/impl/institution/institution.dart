import 'package:universy/apis/institutions/api.dart' as institutionsApi;
import 'package:universy/model/institution/career.dart';
import 'package:universy/model/institution/commission.dart';
import 'package:universy/model/institution/couse.dart';
import 'package:universy/model/institution/institution.dart';
import 'package:universy/model/institution/program.dart';
import 'package:universy/model/institution/queries.dart';
import 'package:universy/model/institution/subject.dart';
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
      return await institutionsApi.getProgramsInfo(programIds);
    } on ServiceException catch (e) {
      Log.getLogger().error(e);
      rethrow;
    } catch (e) {
      Log.getLogger().error(e);
      throw ServiceException();
    }
  }

  @override
  Future<List<Institution>> getInstitutions() async {
    try {
      return await institutionsApi.getInstitutions();
    } on ServiceException catch (e) {
      Log.getLogger().error(e);
      rethrow;
    } catch (e) {
      Log.getLogger().error(e);
      throw ServiceException();
    }
  }

  @override
  Future<List<InstitutionCareer>> getCareers(Institution institution) async {
    try {
      return await institutionsApi.getCareers(institution.id);
    } on ServiceException catch (e) {
      Log.getLogger().error(e);
      rethrow;
    } catch (e) {
      Log.getLogger().error(e);
      throw ServiceException();
    }
  }

  @override
  Future<List<InstitutionProgram>> getPrograms(InstitutionCareer career) async {
    try {
      return await institutionsApi.getPrograms(career.id);
    } on ServiceException catch (e) {
      Log.getLogger().error(e);
      rethrow;
    } catch (e) {
      Log.getLogger().error(e);
      throw ServiceException();
    }
  }

  @override
  Future<List<InstitutionSubject>> getSubjects(String programId) async {
    try {
      return await institutionsApi.getSubjects(programId);
    } on ServiceException catch (e) {
      Log.getLogger().error(e);
      rethrow;
    } catch (e) {
      Log.getLogger().error(e);
      throw ServiceException();
    }
  }

  @override
  Future<List<Course>> getCourses(String subjectId) async {
    try {
      return await institutionsApi.getCourses(subjectId);
    } on ServiceException catch (e) {
      Log.getLogger().error(e);
      rethrow;
    } catch (e) {
      Log.getLogger().error(e);
      throw ServiceException();
    }
  }

  @override
  Future<List<Commission>> getCommissions(String programId) async {
    try {
      return await institutionsApi.getCommissions(programId);
    } on ServiceException catch (e) {
      Log.getLogger().error(e);
      rethrow;
    } catch (e) {
      Log.getLogger().error(e);
      throw ServiceException();
    }
  }
}
