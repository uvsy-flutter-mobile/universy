import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universy/model/institution/forum.dart';
import 'package:universy/modules/institution/forum/items/comments/date_item.dart';
import 'package:universy/widgets/paddings/edge.dart';

class CommentItemWidget extends StatelessWidget {
  final Comment _comment;

  CommentItemWidget({Key key, Comment comment})
      : this._comment = comment,
        super(key: key);

  @override
  Widget build(BuildContext context) {
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
            paddingValue: 5, child: DateItemWidget(date: _comment.date,withTime: true,)));
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
