import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:universy/model/institution/forum.dart';
import 'package:universy/modules/institution/forum/items/comments/date_item.dart';
import 'package:universy/modules/institution/forum/items/comments/comments-list.dart';
import 'package:universy/system/assets.dart';
import 'package:universy/widgets/buttons/uvsy/cancel.dart';
import 'package:universy/widgets/buttons/uvsy/save.dart';
import 'package:universy/widgets/decorations/box.dart';
import 'package:universy/widgets/paddings/edge.dart';

class PublicationDetailWidget extends StatefulWidget {
  final ForumPublication _forumPublication;

  PublicationDetailWidget({Key key, ForumPublication forumPublication})
      : this._forumPublication = forumPublication,
        super(key: key);

  @override
  _PublicationDetailWidgetState createState() => _PublicationDetailWidgetState();
}

class _PublicationDetailWidgetState extends State<PublicationDetailWidget> {
  ScrollController _scrollController = ScrollController();

  bool _newComment;

  @override
  void initState() {
    _newComment = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: Colors.white,
      floatingActionButton: (_newComment)
          ? Icon(
              Icons.add,
              color: Colors.transparent,
              size: 0,
            )
          : _buildFloatingActionButton(),
      body: SymmetricEdgePaddingWidget.horizontal(
          paddingValue: 10,
          child: SymmetricEdgePaddingWidget.vertical(
              paddingValue: 10,
              child: Container(
                child: _buildBody(context),
                decoration: assetImageDecoration(Assets.UNIVERSY_CITY_BACKGROUND),
              ))),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text("Publicación"),
      elevation: 4,
      backgroundColor: Colors.white,
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      controller: _scrollController,
      child: Column(
        children: <Widget>[
          _buildPublication(),
          _buildComments(),
          _buildNewCommentBox(),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildNewCommentBox() {
    if (_newComment == true) {
      return Card(
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: new BorderSide(color: Colors.deepPurple, width: 2.0)),
        elevation: 15,
        child: SymmetricEdgePaddingWidget.vertical(
          paddingValue: 10,
          child: SymmetricEdgePaddingWidget.horizontal(
            paddingValue: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SymmetricEdgePaddingWidget.vertical(
                    paddingValue: 5,
                    child: Text(
                      widget._forumPublication.profile.name,
                      style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
                    )),
                TextField(
                  decoration: InputDecoration(hintText: 'Escribí un comentario...'),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  _buildActionButtons() {
    if (_newComment == true) {
      return SymmetricEdgePaddingWidget.vertical(
          paddingValue: 8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SaveButton(onSave: () => _createButtonAction()),
              CancelButton(onCancel: () => _cancelButtonAction()),
            ],
          ));
    } else {
      return Container();
    }
  }

  _createButtonAction() {}

  void _cancelButtonAction() {
    setState(() {
      _newComment = false;
      _scrollController.animateTo(
        0,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 1000),
      );
    });
  }

  Widget _buildComments() {
    return CommentsListWidget(
      forumPublication: this.widget._forumPublication,
    );
  }

  Widget _buildPublication() {
    return Card(
      elevation: 15,
      child: SymmetricEdgePaddingWidget.vertical(
        paddingValue: 10,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                _buildUserName(),
                _buildPublicationTitle(),
              ],
            ),
            Row(
              children: <Widget>[
                _buildPublicationDescription(),
              ],
            ),
            _buildTagsAndDate()
          ],
        ),
      ),
    );
  }

  Widget _buildUserName() {
    return SymmetricEdgePaddingWidget.horizontal(
      paddingValue: 10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.perm_identity),
          Text(
            this.widget._forumPublication.profile.name,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildPublicationTitle() {
    return Text(
      this.widget._forumPublication.title,
      textAlign: TextAlign.left,
      style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 16),
    );
  }

  Widget _buildTagsAndDate() {
    return SymmetricEdgePaddingWidget.horizontal(
      paddingValue: 20,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _buildTags(),
          Expanded(flex: 5,child: DateItemWidget(date: widget._forumPublication.date,withTime: true,)),
        ],
      ),
    );
  }

  Widget _buildPublicationDescription() {
    return Expanded(
      flex: 2,
      child: SymmetricEdgePaddingWidget.vertical(
        paddingValue: 10,
        child: SymmetricEdgePaddingWidget.horizontal(
          paddingValue: 20,
          child: Text(
            this.widget._forumPublication.description,
            style: TextStyle(),
            overflow: TextOverflow.visible,
          ),
        ),
      ),
    );
  }

  Widget _buildTags() {
    return SymmetricEdgePaddingWidget.vertical(
      paddingValue: 7.0,
      child: Tags(
        spacing: 1.0,
        runSpacing: 1.5,
        alignment: WrapAlignment.start,
        itemCount: widget._forumPublication.tags.length,
        itemBuilder: (int index) {
          return ItemTags(
            key: Key(index.toString()),
            index: index,
            title: "${widget._forumPublication.tags[index]}",
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

  _buildFloatingActionButton() {
    return FloatingActionButton(
      backgroundColor: Colors.deepPurple,
      child: Icon(
        Icons.add_comment,
        size: 30,
      ),
      onPressed: onPressed,
    );
  }

  void onPressed() {
    setState(() {
      _newComment = true;
      _scrollController.animateTo(
        500,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 1000),
      );
    });
  }
}
