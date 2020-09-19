import 'package:flutter/material.dart';
import 'package:universy/util/strings.dart';
import 'package:universy/widgets/paddings/edge.dart';

const EMPTY_STRING = "";

class StudentEventDescriptionWidget extends StatefulWidget {
  final TextEditingController _textEditingController;
  final String _label;
  final String _descriptionLabel;

  const StudentEventDescriptionWidget(
      {Key key,
      @required TextEditingController textEditingController,
      String label,
      String descriptionLabel})
      : this._textEditingController = textEditingController,
        this._label = label,
        this._descriptionLabel = descriptionLabel,
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return DescriptionWidgetState(
        _textEditingController, _label, _descriptionLabel);
  }
}

class DescriptionWidgetState extends State<StudentEventDescriptionWidget> {
  TextEditingController _textEditingController;
  String _label;
  String _descriptionLabel;
  bool _hideDescription = true;

  DescriptionWidgetState(
      this._textEditingController, this._label, this._descriptionLabel)
      : super();

  void initState() {
    _hideDescription = !notNullOrEmpty(this._textEditingController.text);
    super.initState();
  }

  void updateCheckedState(bool newCheckedState) {
    setState(() {
      _hideDescription = newCheckedState;
      if (_hideDescription) {
        _textEditingController.text = EMPTY_STRING;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SymmetricEdgePaddingWidget.vertical(
        paddingValue: 6.0,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 250,
                height: 50,
                child: CheckboxListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text(_descriptionLabel),
                    value: _hideDescription,
                    onChanged: (newCheckedState) =>
                        updateCheckedState(newCheckedState)),
              ),
              Visibility(
                  visible: !_hideDescription,
                  child: TextField(
                    textCapitalization: TextCapitalization.sentences,
                    minLines: 3,
                    keyboardType: TextInputType.multiline,
                    maxLines: 8,
                    maxLength: 150,
                    controller: _textEditingController,
                    decoration: InputDecoration(labelText: _label),
                  ))
            ]));
  }
}
