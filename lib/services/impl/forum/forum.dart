import 'package:universy/apis/forum/api.dart' as forumApi;
import 'package:universy/model/institution/forum.dart';
import 'package:universy/services/exceptions/service.dart';
import 'package:universy/services/impl/student/account.dart';
import 'package:universy/services/impl/student/career.dart';
import 'package:universy/services/manifest.dart';
import 'package:universy/util/logger.dart';
import 'package:universy/util/object.dart';

class DefaultForumService implements ForumService {
  static ForumService _instance;

  DefaultForumService._internal();

  factory DefaultForumService.instance() {
    if (isNull(_instance)) {
      _instance = DefaultForumService._internal();
    }
    return _instance;
  }

  @override
  void dispose() {
    _instance = null;
  }

  @override
  Future<List<ForumPublication>> getForumPublications(String programId) async {
    try {
      return await forumApi.getForumPublications(programId);
    } on ServiceException catch (e) {
      Log.getLogger().error(e);
      rethrow;
    } catch (e) {
      Log.getLogger().error(e);
      throw ServiceException();
    }
  }

  @override
  Future<void> createForumPublication(String title, String description,List<String> tags) async {
    try {
      String userId = await DefaultAccountService.instance().getUserId();
      String programId = await DefaultStudentCareerService.instance().getCurrentProgram();
      ForumPublicationRequest request = new ForumPublicationRequest(title,userId, description,tags,programId);
      return await forumApi.createForumPublication(request);
    } catch (e) {
      Log.getLogger().error(e);
      throw ServiceException();
    }
  }

  @override
  Future<List<Comment>> searchCommentsPublication(String idPublication) async {
    try {
      return await forumApi.searchCommentsPublication(idPublication);
    } catch (e) {
      Log.getLogger().error(e);
      throw ServiceException();
    }
  }


}