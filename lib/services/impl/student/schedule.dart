import 'package:universy/apis/students/requests.dart';
import 'package:universy/model/student/schedule.dart';
import 'package:universy/services/exceptions/service.dart';
import 'package:universy/services/impl/student/account.dart';
import 'package:universy/services/impl/student/career.dart';
import 'package:universy/services/manifest.dart';
import 'package:universy/util/logger.dart';
import 'package:universy/util/object.dart';

import 'package:universy/apis/students/api.dart' as studentApi;

class DefaultStudentScheduleService extends StudentScheduleService {
  static StudentScheduleService _instance;

  DefaultStudentScheduleService._internal();

  factory DefaultStudentScheduleService.instance() {
    if (isNull(_instance)) {
      _instance = DefaultStudentScheduleService._internal();
    }
    return _instance;
  }

  @override
  void dispose() {
    _instance = null;
  }

  @override
  Future<List<StudentScheduleScratch>> getScratches(String programId) async {
    try {
      String userId = await DefaultAccountService.instance().getUserId();
      return studentApi.getScratches(userId, programId);
    } catch (e) {
      Log.getLogger().error(e);
      throw ServiceException();
    }
  }

  Future<void> createScratch(
      StudentScheduleScratch studentScheduleScratch) async {
    try {
      String userId = await DefaultAccountService.instance().getUserId();
      String programId =
          await DefaultStudentCareerService.instance().getCurrentProgram();
      int begin = studentScheduleScratch.beginDate.millisecondsSinceEpoch;
      int end = studentScheduleScratch.endDate.millisecondsSinceEpoch;
      CreateScratchPayload payload = new CreateScratchPayload(
          userId,
          programId,
          studentScheduleScratch.name,
          begin,
          end,
          studentScheduleScratch.selectedCourses);
      return await studentApi.createScheduleScratch(payload);
    } catch (e) {
      Log.getLogger().error(e);
      throw ServiceException();
    }
  }

  Future<void> updateScratch(
      StudentScheduleScratch studentScheduleScratch) async {
    try {
      String scratchId = studentScheduleScratch.scheduleScratchId;
      UpdateScratchPayload payload =
          new UpdateScratchPayload(studentScheduleScratch);
      return await studentApi.updateScheduleScratch(scratchId, payload);
    } catch (e) {
      Log.getLogger().error(e);
      throw ServiceException();
    }
  }

  Future<void> deleteScratch(String scratchId) async {
    try {
      return await studentApi.deleteScheduleScratch(scratchId);
    } catch (e) {
      Log.getLogger().error(e);
      throw ServiceException();
    }
  }
}
