import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:universy/model/institution/forum.dart';
import 'package:universy/modules/institution/forum/bloc/cubit.dart';
import 'package:universy/modules/institution/forum/items/comments/date_item.dart';
import 'package:universy/widgets/async/modal.dart';
import 'package:universy/widgets/paddings/edge.dart';

class PublicationItemWidget extends StatelessWidget {
  final ForumPublication _forumPublication;
  final bool _isOwner;

  PublicationItemWidget({Key key, ForumPublication forumPublication,bool isOwner})
      : this._forumPublication = forumPublication,
        this._isOwner = isOwner,
        super(key: key);


  @override
  Widget build(BuildContext context) {
    if(this._isOwner){
      return _buildOwnerPublicationItem(context);
    }else{
      return _buildNotOwnerPublicationItem(context);
    }
  }


  Widget _buildOwnerPublicationItem(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      enabled: true,
      actionExtentRatio: 0.25,
      child: _buildNotOwnerPublicationItem(context),
      secondaryActions: <Widget>[_buildDeleteSlide(context),_buildUpdateSlide(context)],
    );
  }


  Widget _buildNotOwnerPublicationItem(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _onPublicationTap(context);
      },
      child: Card(
        elevation: 5,
        child: SymmetricEdgePaddingWidget.vertical(
          paddingValue: 4,
          child: SymmetricEdgePaddingWidget.horizontal(
            paddingValue: 2,
            child: _buildRowContent(),
          ),
        ),
      ),
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

  Widget _buildUpdateSlide(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: Colors.grey)),
      ),
      child: _buildUpdateButton(context),
    );
  }

  Widget _buildDeleteButton(BuildContext context) {
    return IconSlideAction(
      color: Colors.red,
      icon: Icons.delete,
      onTap: () => _pressDeletePublicationForumButton(context),
    );
  }

  Widget _buildUpdateButton(BuildContext context) {
    return IconSlideAction(
      color: Colors.grey,
      icon: Icons.edit,
      onTap: () => _pressUpdatePublicationForumButton(context),
    );
  }

  void _pressDeletePublicationForumButton(BuildContext context) async {
    await AsyncModalBuilder()
        .perform(_deleteEvents)
        .withTitle(
        "Eliminando Publicación")
        .then(_refreshForum)
        .build()
        .run(context);
  }

  void _pressUpdatePublicationForumButton(BuildContext context) async {
    BlocProvider.of<InstitutionForumCubit>(context).updateForumPublication(this._forumPublication);
  }

  Future _deleteEvents(BuildContext context) async {
    ///ELIMINAR PUBLICACION
    //var sessionFactory = Provider.of<ServiceFactory>(context, listen: false);
    //var studentEventService = sessionFactory.studentEventService();
    //await studentEventService.deleteStudentEvent(this.event);
  }

  void _refreshForum(BuildContext context) {
    BlocProvider.of<InstitutionForumCubit>(context).fetchPublications();
  }

  Widget _buildRowContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[_buildUserName(), _buildPublicationContent(), _buildExtraInfo()],
    );
  }

  Expanded _buildExtraInfo() {
    return Expanded(
      flex: 1,
      child: SymmetricEdgePaddingWidget.horizontal(
        paddingValue: 2,
        child: Column(
          children: <Widget>[
            _buildPublicationComments(),
            DateItemWidget(date:this._forumPublication.date,withTime: false,),
          ],
        ),
      ),
    );
  }

  Widget _buildPublicationComments() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.comment,
          size: 22,
        ),
        SymmetricEdgePaddingWidget.horizontal(
          paddingValue: 2,
          child: Text(this._forumPublication.comments.length.toString(),
              style: TextStyle(fontSize: 17)),
        ),
      ],
    );
  }

  Widget _buildPublicationContent() {
    return Expanded(
      flex: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildPublicationTitleItem(),
          _buildPublicationDescriptionItem(),
          _buildTags(),
        ],
      ),
    );
  }

  Widget _buildPublicationDescriptionItem() {
    return Text(
      this._forumPublication.description,
      textAlign: TextAlign.left,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: 14),
    );
  }

  Widget _buildPublicationTitleItem() {
    return SymmetricEdgePaddingWidget.vertical(
      paddingValue: 2,
      child: Text(this._forumPublication.title,
          textAlign: TextAlign.left,
          style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 16),
          overflow: TextOverflow.ellipsis),
    );
  }

  Widget _buildTags() {
    return SymmetricEdgePaddingWidget.vertical(
      paddingValue: 7.0,
      child: Tags(
        spacing: 1.0,
        runSpacing: 1.5,
        alignment: WrapAlignment.start,
        itemCount: _forumPublication.tags.length,
        itemBuilder: (int index) {
          return ItemTags(
            key: Key(index.toString()),
            index: index,
            title: "${_forumPublication.tags[index]}",
            pressEnabled: false,
            textStyle: TextStyle(
              fontSize: 10,
            ),
            combine: ItemTagsCombine.withTextBefore,
          );
        },
      ),
    );
  }

  Widget _buildUserName() {
    return Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.perm_identity),
          Text(
            this._forumPublication.profile.name,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  void _onPublicationTap(BuildContext context) {
    BlocProvider.of<InstitutionForumCubit>(context).selectForumPublication(this._forumPublication);
  }
}
