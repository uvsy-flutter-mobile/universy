import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universy/text/text.dart';

const THUMBS_ICON_SIZE = 35.0;

class StudentCourseWouldTakeAgainWidget extends StatefulWidget {
  final bool _wouldTakeAgain;
  final Function(bool) _onChange;

  const StudentCourseWouldTakeAgainWidget(
      {Key key,
      @required bool wouldTakeAgain,
      @required Function(bool) onChange})
      : this._wouldTakeAgain = wouldTakeAgain,
        this._onChange = onChange,
        super(key: key);

  @override
  _StudentCourseWouldTakeAgainWidgetState createState() =>
      _StudentCourseWouldTakeAgainWidgetState();
}

class _StudentCourseWouldTakeAgainWidgetState
    extends State<StudentCourseWouldTakeAgainWidget> {
  bool _wouldTakeAgain;
  Function(bool) _onChange;

  @override
  void initState() {
    this._wouldTakeAgain = widget._wouldTakeAgain;
    this._onChange = widget._onChange;
    super.initState();
  }

  @override
  void dispose() {
    this._onChange = null;
    this._wouldTakeAgain = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 4.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: _buildRateTitle(),
            flex: 4,
          ),
          Expanded(
            child: _buildThumbsIcons(),
            flex: 6,
          )
        ],
      ),
    );
  }

  Widget _buildRateTitle() {
    return SizedBox(
      width: 300,
      child: AutoSizeText(
        AppText.getInstance()
            .get("institution.dashboard.course.labels.wouldTakeAgainTitle"),
        textAlign: TextAlign.center,
        maxLines: 2,
      ),
    );
  }

  Widget _buildThumbsIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildThumbUpIcon(),
        SizedBox(
          width: 25,
        ),
        _buildThumbDownIcon()
      ],
    );
  }

  IconButton _buildThumbUpIcon() {
    return IconButton(
      splashColor: Colors.grey,
      icon: Icon(Icons.thumb_up,
          color: _getThumbUpColor(), size: THUMBS_ICON_SIZE),
      onPressed: () => _wouldTakeAgainAction(true),
    );
  }

  IconButton _buildThumbDownIcon() {
    return IconButton(
      splashColor: Colors.grey,
      icon: Icon(Icons.thumb_down,
          color: _getThumbDownColor(), size: THUMBS_ICON_SIZE),
      onPressed: () => _wouldTakeAgainAction(false),
    );
  }

  void _wouldTakeAgainAction(bool wouldTakeAgain) {
    setState(() {
      _wouldTakeAgain = wouldTakeAgain;
      _onChange(wouldTakeAgain);
    });
  }

  Color _getThumbUpColor() => _wouldTakeAgain ? Colors.green : Colors.black54;

  Color _getThumbDownColor() => _wouldTakeAgain ? Colors.black54 : Colors.red;
}
