import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:universy/constants/strings.dart';
import 'package:universy/text/text.dart';
import 'package:universy/util/object.dart';
import 'package:universy/widgets/formfield/text/validators.dart';
import 'package:universy/widgets/paddings/edge.dart';

class NoteCardWidget extends StatelessWidget {
  final Widget title;
  final Widget description;
  final bool selected;

  const NoteCardWidget._({Key key, this.title, this.description, this.selected})
      : super(key: key);

  factory NoteCardWidget.form(
      {TextEditingController titleController,
      TextEditingController descriptionController}) {
    assert(notNull(titleController));
    assert(notNull(descriptionController));
    var title = _TitleTextField(titleTextController: titleController);
    var description =
        _DescriptionTextField(descriptionTextController: descriptionController);
    return NoteCardWidget._(
        title: title, description: description, selected: false);
  }

  factory NoteCardWidget.display(
      {String titleText,
      String descriptionText,
      DateTime updateDate,
      bool selected = false}) {
    assert(notNull(titleText));
    assert(notNull(descriptionText));
    var title = _TitleDisplay(titleText: titleText, updateDate: updateDate);
    var description = _DescriptionDisplay(descriptionText: descriptionText);
    return NoteCardWidget._(
        title: title, description: description, selected: selected);
  }

  Widget build(BuildContext context) {
    var borderWidth = selected ? 2.0 : 1.0;
    var borderColor = selected ? Colors.amber : Colors.grey;
    return Material(
      borderRadius: BorderRadius.circular(4.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor,
            width: borderWidth,
          ),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: _buildNoteContent(),
      ),
    );
  }

  Widget _buildNoteContent() {
    return AllEdgePaddedWidget(
      padding: 10.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          title,
          SizedBox(height: 10),
          description,
        ],
      ),
    );
  }
}

class _TitleDisplay extends StatelessWidget {
  final String titleText;
  final DateTime updateDate;

  const _TitleDisplay({Key key, this.titleText, this.updateDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat("dd/MM/yyyy hh:mm");
    String date = dateFormat.format(updateDate).toString();
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AutoSizeText(
            titleText,
            textAlign: TextAlign.left,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          AutoSizeText(
            date,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontStyle: FontStyle.italic, fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class _DescriptionDisplay extends StatelessWidget {
  final String descriptionText;

  const _DescriptionDisplay({Key key, this.descriptionText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: AutoSizeText(
        descriptionText,
        overflow: TextOverflow.clip,
        textAlign: TextAlign.left,
        maxLines: 20,
      ),
    );
  }
}

class _TitleTextField extends StatelessWidget {
  final TextEditingController titleTextController;

  const _TitleTextField({Key key, this.titleTextController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      maxLength: 30,
      controller: titleTextController,
      decoration: _buildTitleBarDecoration(),
      style: TextStyle(fontWeight: FontWeight.bold),
      validator: NotEmptyTextFormFieldValidatorBuilder(
              AppText.getInstance().get("student.notes.input.title.required"))
          .build(context),
    );
  }

  InputDecoration _buildTitleBarDecoration() {
    return InputDecoration(
      counterText: EMPTY_STRING,
      hintText: AppText.getInstance().get("student.notes.input.newTitle"),
    );
  }
}

class _DescriptionTextField extends StatelessWidget {
  final TextEditingController descriptionTextController;

  const _DescriptionTextField({Key key, this.descriptionTextController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      textCapitalization: TextCapitalization.sentences,
      minLines: 12,
      keyboardType: TextInputType.multiline,
      maxLines: 12,
      maxLength: 150,
      controller: descriptionTextController,
      decoration: _buildContentBarDecoration(),
    );
  }

  InputDecoration _buildContentBarDecoration() {
    return InputDecoration(
      border: InputBorder.none,
      counterText: EMPTY_STRING,
      hintText: AppText.getInstance().get("student.notes.input.newDescription"),
    );
  }
}
