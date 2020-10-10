import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universy/model/account/profile.dart';
import 'package:universy/model/institution/forum.dart';
import 'package:universy/modules/institution/forum/items/comments/comment_item.dart';

class CommentsListWidget extends StatelessWidget {
  final ForumPublication _forumPublication;
  final Profile _profile;

  CommentsListWidget({Key key, ForumPublication forumPublication, Profile profile})
      : this._forumPublication = forumPublication,
        this._profile = profile,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (this._forumPublication.comments == null || this._forumPublication.comments.isEmpty) {
      return _buildInstitutionForumCommentsNotFoundMessage();
    } else {
      return _buildForumPublicationsList();
    }
  }

  Widget _buildInstitutionForumCommentsNotFoundMessage() {
    return Center(
      child: Text(
        "No se encontraron mensajes para esta publicación",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  Widget _buildForumPublicationsList() {
    List<Widget> column = List<Widget>();
    int x = 0;
    while (this._forumPublication.comments.length > x) {
      Comment comment = this._forumPublication.comments[x];
      bool isOwner = _determinateOwner(comment);
      column.add(CommentItemWidget(comment: comment,isOwner:isOwner));
      x = x + 1;
    }
    return Column(children: column);
  }

  bool _determinateOwner(Comment comment){
    if(comment.profile==this._profile){
      return true;
    }else{return false;}
  }
}
