import 'package:flutter/material.dart';
import 'package:optional/optional.dart';
import 'package:universy/apis/api.dart' as api;
import 'package:universy/model/student/account.dart';
import 'package:universy/model/student/career.dart';
import 'package:universy/model/student/notes.dart';

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

  return api.put(
    resource,
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
