import 'package:universy/apis/api.dart' as api;
import 'package:universy/model/institution/forum.dart';

const basePath = "/frmapi";

String _createPath(String resource) {
  return "$basePath$resource";
}

Future<List<ForumPublication>> getForumPublications(String programId) async {
  var resource = "/publications";
  var path = _createPath(resource);
  var queryParams = {"programId": "$programId","includeTags":"true","includeAlias":"true"};

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

Future<List<Comment>> searchCommentsPublication(String idPublication) async{
  var resource = "/publications/$idPublication/comments";
  var path = _createPath(resource);
  var queryParams = {"limit":"10","includeAlias":"true"};


  var response = await api.getList<Comment>(
    path,
    queryParams: queryParams,
    model: (content) => Comment.fromJson(content),
  );

  return response.orElse([]);
}
