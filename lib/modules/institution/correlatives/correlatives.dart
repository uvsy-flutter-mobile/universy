import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:universy/model/institution/subject.dart';
import 'package:universy/model/subject.dart';
import 'package:universy/text/formaters/subject.dart';
import 'package:universy/text/translators/correlatives.dart';

class CorrelativeSubjectWidget extends StatelessWidget {
  final Subject _subject;
  final CorrelativeCondition _condition;

  const CorrelativeSubjectWidget(
      {Key key, Subject subject, CorrelativeCondition condition})
      : _subject = subject,
        _condition = condition,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(6.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(_subject.name, textAlign: TextAlign.center),
          _buildCorrelativesTags(),
        ],
      ),
    );
  }

  Widget _buildCorrelativesTags() {
    String level = SubjectLevelFormatter(_subject).format();
    String restriction = getConditionDisplayName(_condition);
    List _correlativeTags = [level, restriction];
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
