import 'package:universy/apis/api.dart' as api;
import 'package:universy/model/institution/institution.dart';
import 'package:universy/model/institution/queries.dart';

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

  var queryParams = {"onlyActive": "true"};

  var response = await api.getList<Institution>(
    path,
    queryParams: queryParams,
    model: (content) => Institution.fromJson(content),
  );

  return response.orElse([]);
}
