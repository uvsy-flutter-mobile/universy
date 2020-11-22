import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:linkwell/linkwell.dart';
import 'package:universy/constants/regex.dart';
import 'package:universy/model/institution/forum.dart';
import 'package:universy/modules/institution/forum/bloc/cubit.dart';
import 'package:universy/modules/institution/forum/items/comments/date_item.dart';
import 'package:universy/widgets/async/modal.dart';
import 'package:universy/widgets/paddings/edge.dart';

class CommentItemWidget extends StatelessWidget {
  final Comment _comment;
  final bool _isOwner;


  CommentItemWidget({Key key, Comment comment, bool isOwner, ForumPublication forumPublication})
      : this._comment = comment,
        this._isOwner = isOwner,
        super(key: key);

  List<String> urlList=[];

  @override
  Widget build(BuildContext context) {
    _checkUrl();
    if (this._isOwner) {
      return _buildOwnerCommentItem(context);
    } else {
      return _buildNotOwnerCommentItem(context);
    }
  }

  Widget _buildOwnerCommentItem(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      enabled: true,
      actionExtentRatio: 0.20,
      child: _buildNotOwnerCommentItem(context),
      secondaryActions: <Widget>[_buildDeleteSlide(context)],
    );
  }

  Widget _buildDeleteSlide(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(15),
      ),
      child: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () => _pressDeleteCommentButton(context),
      ),
    );
  }

  void _pressDeleteCommentButton(BuildContext context) async {
    await AsyncModalBuilder().perform(_deleteComment).build().run(context);
  }

  Future _deleteComment(BuildContext context) async {
    BlocProvider.of<InstitutionForumCubit>(context).deleteComment(this._comment);
  }

  Widget _buildNotOwnerCommentItem(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[_buildUserName(), _buildDescription(),
        (urlList.isNotEmpty) ? Divider():Container(),
        SymmetricEdgePaddingWidget.horizontal(paddingValue: 15,child: _buildLinks()),
        (urlList.isNotEmpty) ? Divider():Container(),
        _buildDateItem(context)],
      ),
    );
  }

  void _checkUrl() {
    List<String> list = this._comment.content.split(" ");
    var pattern = Regex.URL_DETECT;
    for (String x in list) {
      if (pattern.hasMatch(x)) {
        Iterable<Match> matches = pattern.allMatches(x);
        urlList.add(matches.first.group(0));
      }
    }
  }

  Widget _buildLinks() {
    if (urlList.isNotEmpty) {
      String url = '';
      int count=1;
      for (String x in urlList) {
        url += "\nLink $count:  $x \n";
        count+=1;
      }
      return LinkWell("$url",style: TextStyle(fontSize: 14,color: Colors.black),linkStyle: TextStyle(fontSize: 15,color: Colors.lightBlue,fontStyle: FontStyle.italic),);
    } else {
      return Container();
    }
  }

  Widget _buildDateItem(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          children: <Widget>[
            (this._comment.voteId == null)
                ? IconButton(
                    icon: Icon(
                      Icons.thumb_up,
                      size: 23,
                      color: Colors.grey,
                    ),
                    onPressed: () => _onVote(context),
                  )
                : IconButton(
                    icon: Icon(
                      Icons.thumb_up,
                      size: 23,
                      color: Colors.black,
                    ),
                    onPressed: () => _onDeleteVote(context),
                  ),
            Text(
              this._comment.votes.toString(),
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
        DateItemWidget(
          date: _comment.date,
          withTime: true,
        ),
      ],
    );
  }

  void _onVote(BuildContext context) {
    BlocProvider.of<InstitutionForumCubit>(context).addVoteComment(this._comment.idComment);
  }

  void _onDeleteVote(BuildContext context) {
    BlocProvider.of<InstitutionForumCubit>(context).deleteVote(this._comment.voteId, false);
  }

  Widget _buildDescription() {
    return SymmetricEdgePaddingWidget.horizontal(
      paddingValue: 15,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Expanded(
              flex: 3,
              child: Text(_comment.content,style: TextStyle(fontSize: 16),),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserName() {
    return SymmetricEdgePaddingWidget.horizontal(
        paddingValue: 10,
        child: SymmetricEdgePaddingWidget.vertical(
          paddingValue: 10,
          child: Row(
            children: <Widget>[
              Text(
                _comment.userAlias,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ));
  }
}
