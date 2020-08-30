import 'package:universy/apis/students/requests.dart';
import 'package:universy/model/student/notes.dart';
import 'package:universy/services/exceptions/service.dart';
import 'package:universy/services/exceptions/student.dart';
import 'package:universy/services/impl/student/account.dart';
import 'package:universy/services/manifest.dart';
import 'package:universy/util/logger.dart';
import 'package:universy/util/object.dart';

import 'package:universy/apis/students/api.dart' as studentApi;

class DefaultStudentNotesService extends StudentNotesService {
  static StudentNotesService _instance;

  DefaultStudentNotesService._internal();

  factory DefaultStudentNotesService.instance() {
    if (isNull(_instance)) {
      _instance = DefaultStudentNotesService._internal();
    }
    return _instance;
  }

  @override
  void dispose() {
    _instance = null;
  }

  @override
  Future<List<StudentNote>> getNotes() async {
    try {
      String userId = await DefaultAccountService.instance().getUserId();
      return studentApi.getNotes(userId);
    } catch (e) {
      Log.getLogger().error(e);
      throw ServiceException();
    }
  }

  @override
  Future<StudentNote> getNote(String noteId) async {
    try {
      String userId = await DefaultAccountService.instance().getUserId();
      var studentNote = await studentApi.getNote(userId, noteId);
      return studentNote.orElseThrow(() => StudentNoteNotFound());
    } catch (e) {
      Log.getLogger().error(e);
      throw ServiceException();
    }
  }

  Future<void> createNote(String title, String description) async {
    try {
      String userId = await DefaultAccountService.instance().getUserId();
      CreateNoteRequest request = new CreateNoteRequest(title, description);
      return await studentApi.createNote(userId, request);
    } catch (e) {
      Log.getLogger().error(e);
      throw ServiceException();
    }
  }

  Future<void> updateNote(
      String noteId, String title, String description) async {
    try {
      String userId = await DefaultAccountService.instance().getUserId();
      UpdateNoteRequest request = new UpdateNoteRequest(title, description);
      return await studentApi.updateNote(userId, noteId, request);
    } catch (e) {
      Log.getLogger().error(e);
      throw ServiceException();
    }
  }

  Future<void> deleteNote(String noteId) async {
    try {
      String userId = await DefaultAccountService.instance().getUserId();
      return await studentApi.deleteNote(userId, noteId);
    } catch (e) {
      Log.getLogger().error(e);
      throw ServiceException();
    }
  }

  Future<void> batchDeleteNotes(List<StudentNote> notes) async {
    try {
      String userId = await DefaultAccountService.instance().getUserId();
      var notesIds = notes.map((n) => n.noteId).toList();
      return await studentApi.batchDeleteNotes(userId, notesIds);
    } catch (e) {
      Log.getLogger().error(e);
      throw ServiceException();
    }
  }
}
