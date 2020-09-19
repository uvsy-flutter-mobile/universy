import 'package:flutter/material.dart';
import 'package:universy/widgets/paddings/edge.dart';

const double SEPARATOR_HEIGHT = 20;

class EmptyItemsWidget extends StatelessWidget {
  final String _title;
  final String _message;

  const EmptyItemsWidget({Key key, String title = "", String message})
      : this._title = title,
        this._message = message,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SymmetricEdgePaddingWidget.horizontal(
        paddingValue: 45, child: _buildContent());
  }

  Column _buildContent() {
    if (this._title.isNotEmpty) {
      return _buildFullContent();
    }
    return _buildOnlyMessage();
  }

  Column _buildFullContent() {
    return Column(
      children: <Widget>[
        _buildTitle(),
        SizedBox(height: SEPARATOR_HEIGHT),
        _buildMessage(),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  Column _buildOnlyMessage() {
    return Column(
      children: <Widget>[
        _buildMessage(),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  Text _buildTitle() {
    return Text(
      this._title,
      style: TextStyle(color: Colors.black, fontSize: 45.0),
      textAlign: TextAlign.center,
    );
  }

  Text _buildMessage() {
    return Text(
      this._message,
      style: TextStyle(color: Colors.black38, fontSize: 22.0),
      textAlign: TextAlign.center,
    );
  }
}
