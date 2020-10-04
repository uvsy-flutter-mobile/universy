import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universy/model/institution/forum.dart';
import 'package:universy/modules/institution/forum/items/comments/institution-comment-item.dart';
import 'package:universy/modules/student/subjects/state/correlative_dialog.dart';
import 'package:universy/widgets/buttons/uvsy/save.dart';
import 'package:universy/widgets/paddings/edge.dart';

class InstitutionCommentsPublication extends StatelessWidget {
  final ForumPublication _forumPublication;

  InstitutionCommentsPublication({Key key, ForumPublication forumPublication})
      : this._forumPublication = forumPublication,
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
    column.add(_buildQuantityOfComments());
    int x = 0;
    while (this._forumPublication.comments.length > x) {
      Comment comment = this._forumPublication.comments[x];
      column.add(InstitutionCommentItem(comment: comment));
      x = x + 1;
    }
    return Column(children: column);
  }

  Widget _buildQuantityOfComments() {
    return SymmetricEdgePaddingWidget.vertical(
      paddingValue: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.comment,
            size: 30,
            color: Colors.grey,
          ),
          SymmetricEdgePaddingWidget.horizontal(
              paddingValue: 10,
              child: Text(
                "${this._forumPublication.comments.length.toString()}" + " Comentarios",
                style: TextStyle(color: Colors.grey, fontSize: 18),
              )),
        ],
      ),
    );
  }

  Widget _buildCommentWidget(Comment comment) {
    return InstitutionCommentItem(
      comment: comment,
    );
  }

  Future<void> _addNewComment(context) async {
    TextEditingController textEditingController = TextEditingController();
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ListView(shrinkWrap: true, children: <Widget>[
          AlertDialog(
            title: Text('Nuevo Comentario'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Divider(),
                TextField(controller: textEditingController, maxLines: 6, maxLength: 200),
                Text("ACLARACION: Una vez publicado el comentario no se permite eliminarlo."),
              ],
            ),
            actions: <Widget>[
              SaveButton(
                onSave: () {
                  _onSaved(textEditingController);
                  Navigator.pop(context);
                },
              ),
              CancelButton()
            ],
          ),
        ]);
      },
    );
  }

  void _onSaved(TextEditingController textEditingController) async {
    if (textEditingController.text.trim().length != 0) {
      //Profile profile = await Services.of(context).profileService().getStudentProfile();
      //Comment comment = Comment(widget._forumPublication.idPublication,profile, textEditingController.text, DateTime.now());
      //await Services.of(context).institutionForumService().updateForumPublication(widget._forumPublication.idPublication,comment);
      //setState(() {
        //widget._forumPublication.comments.add(comment);
      //});
    }
  }
}
