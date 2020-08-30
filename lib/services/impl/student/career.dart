import 'package:optional/optional.dart';
import 'package:universy/apis/errors.dart';
import 'package:universy/apis/students/api.dart' as studentApi;
import 'package:universy/apis/students/requests.dart';
import 'package:universy/model/student/career.dart';
import 'package:universy/services/exceptions/service.dart';
import 'package:universy/services/exceptions/student.dart';
import 'package:universy/services/manifest.dart';
import 'package:universy/storage/impl/student/career.dart';
import 'package:universy/util/logger.dart';
import 'package:universy/util/object.dart';

import 'account.dart';

class DefaultStudentCareerService extends StudentCareerService {
  static StudentCareerService _instance;

  DefaultStudentCareerService._internal();

  factory DefaultStudentCareerService.instance() {
    if (isNull(_instance)) {
      _instance = DefaultStudentCareerService._internal();
    }
    return _instance;
  }

  @override
  void dispose() {
    _instance = null;
  }

  @override
  Future<StudentCareer> getCareer(String programId) async {
    try {
      String userId = await DefaultAccountService.instance().getUserId();
      var career = await studentApi.getCareer(userId, programId);
      return career.orElseThrow(() => CareerNotFound());
    } on NotFound catch (e) {
      Log.getLogger().error(e);
      throw CareerNotFound();
    } on ServiceException catch (e) {
      Log.getLogger().error(e);
      rethrow;
    } catch (e) {
      Log.getLogger().error(e);
      throw ServiceException();
    }
  }

  @override
  Future<List<StudentCareer>> getCareers() async {
    try {
      String userId = await DefaultAccountService.instance().getUserId();
      return studentApi.getCareers(userId);
    } catch (e) {
      Log.getLogger().error(e);
      throw ServiceException();
    }
  }

  @override
  Future<String> getCurrentProgram() async {
    try {
      var storage = DefaultStudentCareerStorage.instance();
      var currentProgram = await storage.getCurrentProgram();

      var careers = await getCareers();

      if (currentProgram.isPresent &&
          careers.any((c) => c.programId == currentProgram.value)) {
        return currentProgram.value;
      }

      if (careers.isNotEmpty) {
        currentProgram = Optional.ofNullable(
          careers.map((c) => c.programId).first,
        );

        if (currentProgram.isPresent) {
          setCurrentProgram(currentProgram.value);
          return currentProgram.value;
        }
      }
      throw CurrentProgramNotFound();
    } on ServiceException catch (e) {
      Log.getLogger().error(e);
      rethrow;
    } catch (e) {
      Log.getLogger().error(e);
      throw ServiceException();
    }
  }

  @override
  Future<void> setCurrentProgram(String programId) async {
    try {
      var storage = DefaultStudentCareerStorage.instance();
      await storage.setCurrentProgram(programId);
    } catch (e) {
      Log.getLogger().error(e);
      throw ServiceException();
    }
  }

  @override
  Future<void> createCareer(String programId, int beginYear) async {
    try {
      String userId = await DefaultAccountService.instance().getUserId();

      var request = CreateCareerRequest(programId, beginYear, null);
      await studentApi.createCareer(userId, request);

      var storage = DefaultStudentCareerStorage.instance();
      await storage.setCurrentProgram(programId);
    } catch (e) {
      Log.getLogger().error(e);
      throw ServiceException();
    }
  }
}
