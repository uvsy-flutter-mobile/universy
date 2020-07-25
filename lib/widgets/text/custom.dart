import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String _text;
  final TextAlign _textAlign;
  final TextStyle _textStyle;
  final TextOverflow _textOverflow;
  final Key _key;

  CustomText.style(
      {Key key,
      @required String text,
      @required TextAlign textAlign,
      @required FontWeight fontWeight,
      @required Color color,
      @required double fontSize,
      @required TextOverflow textOverflow})
      : this._text = text,
        this._textAlign = textAlign,
        this._textStyle = _createTextStyle(fontWeight, color, fontSize),
        this._textOverflow = textOverflow,
        this._key = key;

  CustomText({
    Key key,
    @required String text,
    @required TextAlign textAlign,
    @required TextStyle textStyle,
    @required TextOverflow textOverflow,
  })  : this._text = text,
        this._textAlign = textAlign,
        this._textStyle = textStyle,
        this._textOverflow = textOverflow,
        this._key = key;

  static TextStyle _createTextStyle(
      FontWeight fontWeight, Color color, double fontSize) {
    return TextStyle(fontWeight: fontWeight, color: color, fontSize: fontSize);
  }

  @override
  Widget build(BuildContext context) {
    return Text(_text,
        textAlign: _textAlign,
        overflow: _textOverflow,
        style: _textStyle,
        key: _key);
  }
}

class EllipsisCustomText extends CustomText {
  EllipsisCustomText.leftStyle(
      {@required String text,
      @required FontWeight fontWeight,
      @required Color color,
      @required double fontSize,
      Key key})
      : super.style(
            text: text,
            textAlign: TextAlign.left,
            fontWeight: fontWeight,
            color: color,
            fontSize: fontSize,
            textOverflow: TextOverflow.ellipsis,
            key: key);

  EllipsisCustomText.left(
      {@required String text, @required TextStyle textStyle, Key key})
      : super(
            text: text,
            textAlign: TextAlign.left,
            textOverflow: TextOverflow.ellipsis,
            textStyle: textStyle,
            key: key);
}
