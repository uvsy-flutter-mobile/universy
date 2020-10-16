import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:universy/model/institution/subject.dart';
import 'package:universy/text/formaters/subject.dart';
import 'package:universy/text/translators/correlatives.dart';

class CorrelativeSubjectWidget extends StatelessWidget {
  final CorrelativeItem _correlativeItem;

  const CorrelativeSubjectWidget({Key key, CorrelativeItem correlativeItem})
      : _correlativeItem = correlativeItem,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(6.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(_correlativeItem.name, textAlign: TextAlign.center),
          _buildCorrelativesTags(),
        ],
      ),
    );
  }

  Widget _buildCorrelativesTags() {
    String level = CorrelativeItemLevelFormatter(_correlativeItem).format();
    String condition =
        getConditionDisplayName(_correlativeItem.correlativeCondition);
    List _correlativeTags = [level, condition];
    return Tags(
      itemCount: _correlativeTags.length,
      itemBuilder: (int index) {
        final String tag = _correlativeTags[index];
        return _buildIndividualTags(tag, index);
      },
    );
  }

  Widget _buildIndividualTags(String item, int index) {
    return ItemTags(
      key: Key(index.toString()),
      index: index,
      title: item,
      textScaleFactor: 1.0,
      border: Border.all(color: Colors.transparent),
      padding: EdgeInsets.all(3.0),
      elevation: 0.0,
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
      color: Color(0xFFFFECB3),
      active: false,
      pressEnabled: false,
    );
  }
}
