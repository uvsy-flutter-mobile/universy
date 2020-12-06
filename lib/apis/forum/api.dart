import 'package:universy/apis/api.dart' as api;
import 'package:universy/model/institution/forum.dart';

const basePath = "/frmapi";

String _createPath(String resource) {
  return "$basePath$resource";
}

Future<List<ForumPublication>> getForumPublications(
    String programId, int offset, String userId, List<String> filters) async {
  var resource = "/publications";
  var path = _createPath(resource);
  var queryParams = {
    "programId": "$programId",
    "includeTags": "true",
    "includeAlias": "true",
    "offset": "${offset.toString()}",
    "limit": "15",
    "includeVoteForUserId": "$userId",
    "sortBy":filters[0],
  };
  if (filters.length>1) {queryParams.putIfAbsent("tags", () => filters[1]);}

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
  var resource = "/publications/${request.idPublication}";
  var path = _createPath(resource);

  print(request.toJson().toString());
  return api.put(
    path,
    payload: request,
  );
}

Future<List<Comment>> searchCommentsPublication(String idPublication, String userId) async {
  var resource = "/comments";
  var path = _createPath(resource);
  var queryParams = {
    "publicationId": "$idPublication",
    "includeAlias": "true",
    "includeVoteForUserId": "$userId"
  };

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
    payload: request,
  );
}

Future<void> addVotePublication(VotePublicationRequest request) {
  var resource = "/votes/publications";
  var path = _createPath(resource);

  return api.post(
    path,
    payload: request,
  );
}

Future<void> reportPublication(VotePublicationRequest request) {
  //var resource = "/votes/publications";
  //var path = _createPath(resource);

  //return api.post(    path,    payload: request,  );
}

Future<void> reportComment(VotePublicationRequest request) {
  //var resource = "/votes/publications";
  //var path = _createPath(resource);

  //return api.post(    path,    payload: request,  );
}


Future<void> addVoteComment(VoteCommentRequest request) {
  var resource = "/votes/comments";
  var path = _createPath(resource);

  return api.post(
    path,
    payload: request,
  );
}

Future<void> deleteVote(String idVote, String route) {
  var resource = "/votes/$route/$idVote";
  var path = _createPath(resource);

  return api.delete(
    path,
  );
}
