import 'package:universy/apis/errors.dart';
import 'package:universy/apis/students/api.dart' as studentApi;
import 'package:universy/model/student/event.dart';
import 'package:universy/services/exceptions/service.dart';
import 'package:universy/services/manifest.dart';
import 'package:universy/util/logger.dart';
import 'package:universy/util/object.dart';

import 'account.dart';

//TODO: Creates exception for this service
class DefaultStudentEventService extends StudentEventService {
  static StudentEventService _instance;

  DefaultStudentEventService._internal();

  factory DefaultStudentEventService.instance() {
    if (isNull(_instance)) {
      _instance = DefaultStudentEventService._internal();
    }
    return _instance;
  }

  @override
  void dispose() {
    _instance = null;
  }

  @override
  Future<void> createEvent(StudentEvent event) async {
    try {
      String userId = await DefaultAccountService.instance().getUserId();
      await studentApi.createEvent(userId, event);
    } catch (e) {
      Log.getLogger().error(e);
      throw ServiceException();
    }
  }

  @override
  Future<List<StudentEvent>> getStudentEvents(
      DateTime dateFrom, DateTime dateTo) async {
    try {
      String userId = await DefaultAccountService.instance().getUserId();
      return studentApi.getEvents(userId, dateFrom, dateTo);
    } on ServiceException catch (e) {
      Log.getLogger().error(e);
      rethrow;
    } catch (e) {
      Log.getLogger().error(e);
      throw ServiceException();
    }
  }

  @override
  Future<void> deleteStudentEvent(StudentEvent studentEvent) async {
    try {
      return studentApi.deleteEvent(studentEvent.userId, studentEvent.eventId);
    } on ServiceException catch (e) {
      Log.getLogger().error(e);
      rethrow;
    } catch (e) {
      Log.getLogger().error(e);
      throw ServiceException();
    }
  }

  @override
  Future<void> updateEvent(StudentEvent studentEvent) async {
    try {
      return studentApi.updateEvent(
          studentEvent.userId, studentEvent.eventId, studentEvent);
    } on ServiceException catch (e) {
      Log.getLogger().error(e);
      rethrow;
    } catch (e) {
      Log.getLogger().error(e);
      throw ServiceException();
    }
  }
}
