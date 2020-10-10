import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:universy/model/institution/forum.dart';
import 'package:universy/modules/institution/forum/bloc/cubit.dart';
import 'package:universy/modules/institution/forum/items/comments/date_item.dart';
import 'package:universy/widgets/async/modal.dart';
import 'package:universy/widgets/paddings/edge.dart';

class CommentItemWidget extends StatelessWidget {
  final Comment _comment;
  final bool _isOwner;

  CommentItemWidget({Key key, Comment comment, bool isOwner})
      : this._comment = comment,
        this._isOwner = isOwner,
        super(key: key);



  @override
  Widget build(BuildContext context) {
    if(this._isOwner){
      return _buildOwnerCommentItem(context);
    }else{
      return _buildNotOwnerCommentItem(context);
    }
  }

  Widget _buildOwnerCommentItem(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      enabled: true,
      actionExtentRatio: 0.25,
      child: _buildNotOwnerCommentItem(context),
      secondaryActions: <Widget>[_buildDeleteSlide(context)],
    );
  }

  Widget _buildDeleteSlide(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: Color(0xFFC9C9C9))),
      ),
      child: _buildDeleteButton(context),
    );
  }

  Widget _buildDeleteButton(BuildContext context) {
    return IconSlideAction(
      color: Colors.red,
      icon: Icons.delete,
      onTap: () => _pressDeletePublicationForumButton(context),
    );
  }

  void _pressDeletePublicationForumButton(BuildContext context) async {
    await AsyncModalBuilder()
        .perform(_deleteEvents)
        .withTitle(
        "Eliminando Comentario")
        .then(_refreshForum)
        .build()
        .run(context);
  }

  Future _deleteEvents(BuildContext context) async {
    ///ELIMINAR COMENTARIO
    //var sessionFactory = Provider.of<ServiceFactory>(context, listen: false);
    //var studentEventService = sessionFactory.studentEventService();
    //await studentEventService.deleteStudentEvent(this.event);
  }

  void _refreshForum(BuildContext context) {
    BlocProvider.of<InstitutionForumCubit>(context).fetchPublications();
  }

  Widget _buildNotOwnerCommentItem(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      child: Column(
        children: <Widget>[_buildUserName(), _buildDescription(), _buildDateItem()],
      ),
    );
  }

  Widget _buildDateItem() {
    return SymmetricEdgePaddingWidget.horizontal(
        paddingValue: 5,
        child: SymmetricEdgePaddingWidget.vertical(
            paddingValue: 5,
            child: DateItemWidget(
              date: _comment.date,
              withTime: true,
            )));
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
              child: Text(_comment.description),
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
                _comment.profile.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ));
  }
}
