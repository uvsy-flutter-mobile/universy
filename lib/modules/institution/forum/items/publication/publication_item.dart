import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:universy/model/institution/forum.dart';
import 'package:universy/modules/institution/forum/bloc/cubit.dart';
import 'package:universy/modules/institution/forum/items/comments/date_item.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/buttons/uvsy/cancel.dart';
import 'package:universy/widgets/paddings/edge.dart';

class PublicationItemWidget extends StatelessWidget {
  final ForumPublication _forumPublication;
  final bool _isOwner;

  PublicationItemWidget({Key key, ForumPublication forumPublication, bool isOwner})
      : this._forumPublication = forumPublication,
        this._isOwner = isOwner,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (this._isOwner) {
      return _buildOwnerPublicationItem(context);
    } else {
      return _buildNotOwnerPublicationItem(context);
    }
  }

  Widget _buildOwnerPublicationItem(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      enabled: true,
      actionExtentRatio: 0.20,
      child: _buildNotOwnerPublicationItem(context),
      secondaryActions: <Widget>[_buildDeleteSlide(context), _buildUpdateSlide(context)],
    );
  }

  Widget _buildNotOwnerPublicationItem(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _onPublicationTap(context);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
              color: (this._forumPublication.isReported == true && this._isOwner == true)
                  ? Colors.red
                  : Colors.transparent),
          borderRadius: BorderRadius.circular(5),
        ),
        elevation: 2.5,
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
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(15),
      ),
      child: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () => _deletePublication(context),
      ),
    );
  }

  Widget _buildUpdateSlide(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(15),
      ),
      child: IconButton(
        icon: Icon(Icons.edit),
        onPressed: () => _pressUpdatePublicationForumButton(context),
      ),
    );
  }

  void _pressUpdatePublicationForumButton(BuildContext context) async {
    BlocProvider.of<InstitutionForumCubit>(context)
        .updateForumPublicationState(this._forumPublication);
  }

  Future _deletePublication(BuildContext context) async {
    BlocProvider.of<InstitutionForumCubit>(context).deleteForumPublication(this._forumPublication);
  }

  Widget _buildRowContent() {
    return Row(
      children: <Widget>[
        Expanded(flex: 2, child: _buildUserName()),
        Expanded(flex: 4, child: _buildPublicationContent()),
        _buildExtraInfo()
      ],
    );
  }

  Widget _buildExtraInfo() {
    return SymmetricEdgePaddingWidget.horizontal(
      paddingValue: 4,
      child: Column(
        children: <Widget>[
          _buildPublicationComments(),
          _buildVotes(),
          DateItemWidget(
            date: this._forumPublication.date,
            withTime: false,
          ),
        ],
      ),
    );
  }

  Widget _buildVotes() {
    return SymmetricEdgePaddingWidget.vertical(
      paddingValue: 5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Icon(
            Icons.thumb_up,
            size: 22,
          ),
          SymmetricEdgePaddingWidget.horizontal(
              paddingValue: 2,
              child: Text(
                this._forumPublication.votes.toString(),
                style: TextStyle(fontSize: 16),
              )),
        ],
      ),
    );
  }

  Widget _buildPublicationComments() {
    return Row(
      children: <Widget>[
        Icon(
          Icons.comment,
          size: 22,
        ),
        SymmetricEdgePaddingWidget.horizontal(
          paddingValue: 2,
          child: Text(this._forumPublication.comments.toString(), style: TextStyle(fontSize: 17)),
        ),
      ],
    );
  }

  Widget _buildPublicationContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        (this._forumPublication.isReported) ? Container() : _buildPublicationTitleItem(),
        (this._forumPublication.isReported)
            ? _buildPublicationReportedDescription()
            : _buildPublicationDescriptionItem(),
        (this._forumPublication.isReported) ? Container() : _buildTags(),
      ],
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

  Widget _buildPublicationReportedDescription() {
    return Text(
      AppText.getInstance().get("institution.forum.publication.reportedPublication"),
      textAlign: TextAlign.left,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
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
        spacing: 2.5,
        runSpacing: 1.5,
        alignment: WrapAlignment.start,
        itemCount: _forumPublication.tags.length,
        itemBuilder: (int index) {
          return ItemTags(
            key: Key(index.toString()),
            index: index,
            title: "${_forumPublication.tags[index]}",
            pressEnabled: false,
            activeColor: Colors.grey[350],
            color: Colors.grey[350],
            textActiveColor: Colors.black,
            textColor: Colors.black,
            elevation: 0,
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
    String alias = (this._forumPublication.userAlias == null)
        ? AppText.getInstance().get("institution.forum.publication.defaultUser")
        : this._forumPublication.userAlias;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Icon(
          (_isOwner) ? Icons.person : Icons.perm_identity,
          color: Colors.black,
        ),
        Text(
          alias,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: Colors.black, fontWeight: (_isOwner) ? FontWeight.bold : FontWeight.normal),
        ),
      ],
    );
  }

  void _onPublicationTap(BuildContext context) {
    if (this._forumPublication.isReported) {
      showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              shape: _buildShapeDialog(),
              title: Text(
                AppText.getInstance().get("institution.forum.publication.reportedPublication"),
                textAlign: TextAlign.center,
              ),
              content: Text(
                AppText.getInstance()
                    .get("institution.forum.publication.reportedPublicationDescription"),
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[
                CancelButton(
                  onCancel: () => Navigator.of(context).pop(true),
                )
              ],
            ),
          ) ??
          false;
    } else {
      print(this._forumPublication.idPublication);
      BlocProvider.of<InstitutionForumCubit>(context)
          .viewDetailForumPublicationState(this._forumPublication);
    }
  }

  ShapeBorder _buildShapeDialog() {
    return RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0)));
  }
}
