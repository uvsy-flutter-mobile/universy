import 'package:universy/apis/api.dart' as api;
import 'package:universy/model/institution/forum.dart';

const basePath = "/frmapi";

String _createPath(String resource) {
  return "$basePath$resource";
}

Future<List<ForumPublication>> getForumPublications(String programId, int offset) async {
  var resource = "/publications";
  var path = _createPath(resource);
  var queryParams = {"programId": "$programId", "includeTags": "true", "includeAlias": "true","limit":"100","offset":"${offset.toString()}"};

  var response = await api.getList<ForumPublication>(
    path,
    queryParams: queryParams,
    model: (content) => ForumPublication.fromJson(content),
  );

  return response.orElse([]);
}

Future<void> createForumPublication(ForumPublicationRequest request) {
  var resource = "/publications";
  var path = _createPath(resource);

  return api.post(
    path,
    payload: request,
  );
}

Future<void> updateForumPublication(ForumPublicationUpdateRequest request) {
  print(request.title);
  print(request.description);
  print(request.idPublication);
  print(request);
  var resource = "/publications/${request.idPublication}";
  var path = _createPath(resource);
  print("path" + path);

  return api.put(
    path,
    payload: request,
  );
}

Future<List<Comment>> searchCommentsPublication(String idPublication) async {
  var resource = "/comments";
  var path = _createPath(resource);
  var queryParams = {"publicationId":"$idPublication","includeAlias":"true"};

  var response = await api.getList<Comment>(
    path,
    queryParams: queryParams,
    model: (content) => Comment.fromJson(content),
  );

  return response.orElse([]);
}

Future<void> deletePublication(String idPublication) {
  var resource = "/publications/$idPublication";
  var path = _createPath(resource);

  return api.delete(
    path,
  );
}

Future<void> deleteComment(String idComment) {
  var resource = "/comments/$idComment";
  var path = _createPath(resource);

  return api.delete(
    path,
  );
}

Future<void> insertComment(CommentRequest request) {
  var resource = "/comments";
  var path = _createPath(resource);

  return api.post(
    path,
    payload:request,
  );
}
