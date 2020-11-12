import 'package:universy/apis/errors.dart';
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
  Future<List<ForumPublication>> getForumPublications(String programId, int offset, String userId, List<String> filters) async {
    List<String> filters2 = filters;
    if(filters.isEmpty){filters2.add("-creation");}
    try {
      return await forumApi.getForumPublications(programId, offset,userId, filters2);
    }on InternalError {
      return [];
    }
    on ServiceException catch (e) {
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
  Future<void> updateForumPublication(String title, String description,List<String> tags, String idPublication) async {
    try {
      ForumPublicationUpdateRequest request = new ForumPublicationUpdateRequest(title,description,tags,idPublication);
      return await forumApi.updateForumPublication(request);
    } catch (e) {
      Log.getLogger().error(e);
      throw ServiceException();
    }
  }

  @override
  Future<void> deleteForumPublication(String idPublication) async {
    try {
      return await forumApi.deletePublication(idPublication);
    } catch (e) {
      Log.getLogger().error(e);
      throw ServiceException();
    }
  }

  @override
  Future<List<Comment>> getCommentsPublication(String idPublication,String userId) async {
    try {
      return await forumApi.searchCommentsPublication(idPublication,userId);
    } catch (e) {
      Log.getLogger().error(e);
      throw ServiceException();
    }
  }

  @override
  Future<void> deleteComment(String idComment) async {
    try {
      return await forumApi.deleteComment(idComment);
    } catch (e) {
      Log.getLogger().error(e);
      throw ServiceException();
    }
  }

  @override
  Future<void> createComment(String userId, String content, String idPublication) async {
    CommentRequest request = CommentRequest(userId,content,idPublication);
    try {
      return await forumApi.insertComment(request);
    } catch (e) {
      Log.getLogger().error(e);
      throw ServiceException();
    }
  }


  @override
  Future<void> addVotePublication(String userId, String idPublication) async {
    VotePublicationRequest request = VotePublicationRequest(userId,idPublication);
    try {
      return await forumApi.addVotePublication(request);
    } catch (e) {
      Log.getLogger().error(e);
      throw ServiceException();
    }
  }

  @override
  Future<void> addVoteComment(String userId, String idComment) async {
    VoteCommentRequest request = VoteCommentRequest(userId,idComment);
    try {
      return await forumApi.addVoteComment(request);
    } catch (e) {
      Log.getLogger().error(e);
      throw ServiceException();
    }
  }

  @override
  Future<void> deleteVote(String idVote, bool isPublication) async {
    String route ='';
    if(isPublication){route="publications";}else{route="comments";}
    try {
      return await forumApi.deleteVote(idVote,route);
    } catch (e) {
      Log.getLogger().error(e);
      throw ServiceException();
    }
  }
}