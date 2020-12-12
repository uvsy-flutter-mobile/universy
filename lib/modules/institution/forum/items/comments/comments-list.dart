import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universy/model/account/profile.dart';
import 'package:universy/model/institution/forum.dart';
import 'package:universy/modules/institution/forum/items/comments/comment_item.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/paddings/edge.dart';

class CommentsListWidget extends StatelessWidget {
  final List<Comment> _commentsList;
  final Profile _profile;

  CommentsListWidget({Key key, List<Comment> commentsList, Profile profile,})
      : this._commentsList = commentsList,
        this._profile = profile,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (this._commentsList == null || this._commentsList.isEmpty) {
      return _buildInstitutionForumCommentsNotFoundMessage();
    } else {
      return _buildForumPublicationsList();
    }
  }

  Widget _buildInstitutionForumCommentsNotFoundMessage() {
    return SymmetricEdgePaddingWidget.vertical(
      paddingValue: 10,
      child: SymmetricEdgePaddingWidget.horizontal(
        paddingValue: 10,
        child: Center(
          child: Text(
            AppText.getInstance().get("institution.forum.comments.commentsNotFound"),
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget _buildForumPublicationsList() {
    List<Widget> column = List<Widget>();
    int x = 0;
    while (this._commentsList.length > x) {
      Comment comment = this._commentsList[x];
      bool isOwner = _determinateOwner(comment);
      print(this._commentsList[x].isReported);
      column.add(CommentItemWidget(comment: comment,isOwner:isOwner,profile:_profile));
      x = x + 1;
    }
    return Column(children: column);
  }

  bool _determinateOwner(Comment comment){
    if(comment.userId==this._profile.userId){
      return true;
    }else{return false;}
  }
}
