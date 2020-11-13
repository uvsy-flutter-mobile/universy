import 'package:flutter/material.dart';
import 'package:universy/widgets/builder/builder.dart';

abstract class InputDecorationBuilder
    implements ComponentBuilder<InputDecoration> {}

class IconButtonInputDecorationBuilder implements InputDecorationBuilder {
  final String _labelText;
  final Icon _icon;
  final VoidCallback _onPressed;

  IconButtonInputDecorationBuilder(
      {@required String labelText,
      @required Icon icon,
      @required VoidCallback onPressed})
      : this._labelText = labelText,
        this._icon = icon,
        this._onPressed = onPressed;

  @override
  InputDecoration build(BuildContext context) {
    return InputDecoration(
        labelText: _labelText,
        suffixIcon: IconButton(icon: _icon, onPressed: _onPressed));
  }
}

class TextInputDecorationBuilder implements InputDecorationBuilder {
  final String _labelText;

  TextInputDecorationBuilder(this._labelText);

  @override
  InputDecoration build(BuildContext context) {
    return InputDecoration(labelText: _labelText);
  }
}

class ForumInputDescriptionDecorationBuilder implements InputDecorationBuilder {
  final String _labelText;

  ForumInputDescriptionDecorationBuilder(this._labelText);

  @override
  InputDecoration build(BuildContext context) {
    return InputDecoration.collapsed(
        hintText: _labelText, hintStyle: TextStyle(color: Colors.grey));
  }
}

class ForumInputTitleDecorationBuilder implements InputDecorationBuilder {
  final String _labelText;

  ForumInputTitleDecorationBuilder(this._labelText);

  @override
  InputDecoration build(BuildContext context) {
    return InputDecoration.collapsed(
        hintText: _labelText,
        hintStyle: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold));
  }
}

class ForumInputNewCommentBuilder implements InputDecorationBuilder {
  final String _labelText;

  ForumInputNewCommentBuilder(this._labelText);

  @override
  InputDecoration build(BuildContext context) {
    return InputDecoration(
        hintText:
        _labelText);
  }
}
