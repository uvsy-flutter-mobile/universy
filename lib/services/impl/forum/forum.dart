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
  Future<List<ForumPublication>> getForumPublications(String programId, int offset) async {
    try {
      return await forumApi.getForumPublications(programId, offset);
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
  Future<void> updateForumPublication(String title, String description,List<String> tags) async {
    try {
      ForumPublicationUpdateRequest request = new ForumPublicationUpdateRequest(title,description,tags);
      return await forumApi.updateForumPublication(request);
    } catch (e) {
      Log.getLogger().error(e);
      throw ServiceException();
    }
  }

  @override
  Future<List<Comment>> getCommentsPublication(String idPublication) async {
    try {
      return await forumApi.searchCommentsPublication(idPublication);
    } catch (e) {
      Log.getLogger().error(e);
      throw ServiceException();
    }
  }

  @override
  Future<void> deleteForumPublication(String idPublication) async {
    try {
      print(idPublication);
      return await forumApi.deletePublication(idPublication);
    } catch (e) {
      Log.getLogger().error(e);
      throw ServiceException();
    }
  }

  @override
  Future<void> deletePublicationComment(String idComment) async {
    print(idComment);
    try {
      return await forumApi.deleteComment(idComment);
    } catch (e) {
      Log.getLogger().error(e);
      throw ServiceException();
    }
  }

  @override
  Future<void> createCommentPublication(String userId, String content, String idPublication) async {
    CommentRequest request = CommentRequest(userId,content,idPublication);
    try {
      return await forumApi.insertComment(request);
    } catch (e) {
      Log.getLogger().error(e);
      throw ServiceException();
    }
  }


}