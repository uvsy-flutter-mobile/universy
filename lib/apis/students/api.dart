import 'package:intl/intl.dart';
import 'package:optional/optional.dart';
import 'package:universy/apis/api.dart' as api;
import 'package:universy/model/account/profile.dart';
import 'package:universy/model/student/career.dart';
import 'package:universy/model/student/event.dart';
import 'package:universy/model/student/notes.dart';
import 'package:universy/model/student/schedule.dart';
import 'package:universy/model/student/subject.dart';

import 'requests.dart';

const basePath = "/stdnapi";

String _createPath(String resource) {
  return "$basePath$resource";
}

// Profile

Future<Optional<Profile>> getProfile(String userId) {
  var resource = "/profile/$userId";
  var path = _createPath(resource);

  return api.get<Profile>(
    path,
    model: (content) => Profile.fromJson(content),
  );
}

Future<void> updateProfile(String userId, UpdateProfileRequest request) {
  var resource = "/profile/$userId";
  var path = _createPath(resource);

  return api.put(
    path,
    payload: request,
  );
}

Future<void> createProfile(Profile profile) {
  var resource = "/profile";
  var path = _createPath(resource);

  return api.post(
    path,
    payload: profile,
  );
}

Future<void> checkAliasProfile(String userId, String newAlias) {
  var resource = "/alias/availability";
  var path = _createPath(resource);

  return api.get(path, queryParams: {"user_id": userId, "alias": newAlias});
}

// Career

Future<List<StudentCareer>> getCareers(String userId) async {
  var resource = "/students/$userId/careers";
  var path = _createPath(resource);

  var response = await api.getList<StudentCareer>(
    path,
    model: (content) => StudentCareer.fromJson(content),
  );

  return response.orElse([]);
}

Future<void> createCareer(String userId, CreateCareerRequest request) async {
  var resource = "/students/$userId/careers";
  var path = _createPath(resource);

  await api.post(
    path,
    payload: request,
  );
}

Future<Optional<StudentCareer>> getCareer(
    String userId, String programId) async {
  var resource = "/students/$userId/careers/$programId";
  var path = _createPath(resource);

  return await api.get<StudentCareer>(
    path,
    model: (content) => StudentCareer.fromJson(content),
  );
}

Future<List<StudentSubject>> getSubjects(
    String userId, String programId) async {
  var resource = "/students/$userId/subjects";
  var path = _createPath(resource);
  var queryParams = {"programId": programId};

  var response = await api.getList<StudentSubject>(
    path,
    queryParams: queryParams,
    model: (content) => StudentSubject.fromJson(content),
  );

  return response.orElse([]);
}

// Profile
// Notes
Future<List<StudentNote>> getNotes(String userId) async {
  var resource = "/students/$userId/notes";
  var path = _createPath(resource);

  var response = await api.getList<StudentNote>(
    path,
    model: (content) => StudentNote.fromJson(content),
  );

  return response.orElse([]);
}

Future<Optional<StudentNote>> getNote(String userId, String noteId) async {
  var resource = "/students/$userId/careers/$noteId";
  var path = _createPath(resource);

  return await api.get<StudentNote>(
    path,
    model: (content) => StudentNote.fromJson(content),
  );
}

Future<void> createNote(String userId, CreateNoteRequest request) {
  var resource = "/students/$userId/notes";
  var path = _createPath(resource);

  return api.post(
    path,
    payload: request,
  );
}

Future<void> updateNote(
    String userId, String noteId, UpdateNoteRequest request) {
  var resource = "/students/$userId/notes/$noteId";
  var path = _createPath(resource);

  return api.put(
    path,
    payload: request,
  );
}

Future<void> deleteNote(String userId, noteId) {
  var resource = "/students/$userId/notes/$noteId";
  var path = _createPath(resource);

  return api.delete(path);
}

Future<void> batchDeleteNotes(String userId, List<String> noteIds) {
  var resource = "/students/$userId/notes";
  var path = _createPath(resource);

  var queryParams = {"noteIds": noteIds.join(",")};

  return api.delete(path, queryParams: queryParams);
}

// Subjects
Future<void> updateSubject(
    String userId, String subjectId, UpdateSubjectPayload payload) {
  var resource = "/students/$userId/subjects/$subjectId";
  var path = _createPath(resource);

  return api.put(
    path,
    payload: payload,
  );
}

Future<void> deleteSubject(String userId, String subjectId) {
  var resource = "/students/$userId/subjects/$subjectId";
  var path = _createPath(resource);

  return api.delete(
    path,
  );
}

// Events
Future<List<StudentEvent>> getEvents(
    String userId, DateTime dateFrom, DateTime dateTo) async {
  DateFormat dateFormat = DateFormat("dd-MMM-yyyy");
  String newDateFrom = dateFormat.format(dateFrom).toString();
  String newDateTo = dateFormat.format(dateTo).toString();

  var resource = "/students/$userId/events";
  var path = _createPath(resource);
  var queryParams = {"dateFrom": newDateFrom, "dateTo": newDateTo};

  var response = await api.getList<StudentEvent>(
    path,
    queryParams: queryParams,
    model: (content) => StudentEvent.fromJson(content),
  );

  return response.orElse([]);
}

Future<void> createEvent(String userId, StudentEvent studentEvent) {
  var resource = "/students/$userId/events";
  var path = _createPath(resource);

  return api.post(
    path,
    payload: studentEvent,
  );
}

Future<void> deleteEvent(String userId, String eventId) {
  var resource = "/students/$userId/events/$eventId";
  var path = _createPath(resource);

  return api.delete(path);
}

Future<void> updateEvent(
    String userId, String eventId, StudentEvent studentEvent) {
  var resource = "/students/$userId/events/$eventId";
  var path = _createPath(resource);

  return api.put(path, payload: studentEvent);
}

// Schedule Scratches
Future<List<StudentScheduleScratch>> getScratches(
    String userId, String programId) async {
  var resource =
      "/students/$userId/programs/$programId/schedules"; //TODO: check with gon
  var path = _createPath(resource);

  var response = await api.getList<StudentScheduleScratch>(
    path,
    model: (content) => StudentScheduleScratch.fromJson(content),
  );

  return response.orElse([]);
}

Future<void> createScheduleScratch(
    String userId, String programId, CreateScratchPayload payload) {
  var resource =
      "/students/$userId/programs/$programId/schedules"; //TODO check with gon
  var path = _createPath(resource);

  return api.post(
    path,
    payload: payload,
  );
}

Future<void> updateScheduleScratch(String userId, String programId,
    String scratchId, UpdateScratchPayload payload) {
  var resource =
      "/students/$userId/programs/$programId/schedules/$scratchId"; //TODO check with gon
  var path = _createPath(resource);

  return api.put(
    path,
    payload: payload,
  );
}

Future<void> deleteScheduleScratch(
    String userId, String programId, String scratchId) {
  var resource =
      "/students/$userId/programs/$programId/schedules/$scratchId"; //TODO check with gon
  var path = _createPath(resource);

  return api.delete(path);
}
