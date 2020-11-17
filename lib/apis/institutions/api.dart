import 'package:optional/optional.dart';
import 'package:universy/apis/api.dart' as api;
import 'package:universy/model/institution/career.dart';
import 'package:universy/model/institution/commission.dart';
import 'package:universy/model/institution/course.dart';
import 'package:universy/model/institution/institution.dart';
import 'package:universy/model/institution/program.dart';
import 'package:universy/model/institution/queries.dart';
import 'package:universy/model/institution/subject.dart';

const basePath = "/instapi";

String _createPath(String resource) {
  return "$basePath$resource";
}

// Queries

Future<List<InstitutionProgramInfo>> getProgramsInfo(
    List<String> programsIds) async {
  var resource = "/query/programs/info";
  var path = _createPath(resource);

  var queryParams = {"programIds": programsIds.join(",")};

  var response = await api.getList<InstitutionProgramInfo>(
    path,
    queryParams: queryParams,
    model: (content) => InstitutionProgramInfo.fromJson(content),
  );

  return response.orElse([]);
}

// Institutions
Future<List<Institution>> getInstitutions() async {
  var resource = "/institutions";
  var path = _createPath(resource);

  var queryParams = {"only_active": "true"};

  var response = await api.getList<Institution>(
    path,
    queryParams: queryParams,
    model: (content) => Institution.fromJson(content),
  );

  return response.orElse([]);
}

Future<List<InstitutionCareer>> getCareers(String institutionId) async {
  var resource = "/institutions/$institutionId/careers";
  var path = _createPath(resource);

  var queryParams = {"only_active": "true"};

  var response = await api.getList<InstitutionCareer>(
    path,
    queryParams: queryParams,
    model: (content) => InstitutionCareer.fromJson(content),
  );

  return response.orElse([]);
}

Future<List<InstitutionProgram>> getPrograms(String careerId) async {
  var resource = "/careers/$careerId/programs";
  var path = _createPath(resource);

  var queryParams = {"only_active": "true"};

  var response = await api.getList<InstitutionProgram>(
    path,
    queryParams: queryParams,
    model: (content) => InstitutionProgram.fromJson(content),
  );

  return response.orElse([]);
}

Future<Optional<InstitutionProgram>> getProgram(String programId) async {
  var resource = "/programs/$programId";
  var path = _createPath(resource);

  return await api.get<InstitutionProgram>(
    path,
    model: (content) => InstitutionProgram.fromJson(content),
  );
}

Future<List<InstitutionSubject>> getSubjects(String programId) async {
  var resource = "/programs/$programId/subjects";
  var path = _createPath(resource);

  var response = await api.getList<InstitutionSubject>(
    path,
    model: (content) => InstitutionSubject.fromJson(content),
  );

  return response.orElse([]);
}

Future<List<Course>> getCourses(String subjectId) async {
  var resource = "/subjects/$subjectId/courses";
  var path = _createPath(resource);

  var response = await api.getList<Course>(
    path,
    model: (content) => Course.fromJson(content),
  );

  return response.orElse([]);
}

Future<List<Commission>> getCommissions(String programId) async {
  var resource = "/programs/$programId/commissions";
  var path = _createPath(resource);

  var response = await api.getList<Commission>(
    path,
    model: (content) => Commission.fromJson(content),
  );

  return response.orElse([]);
}
