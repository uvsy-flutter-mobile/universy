import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:universy/model/student/subject.dart';
import 'package:universy/model/time.dart';
import 'package:universy/modules/student/subjects/state/milestones/commands/command.dart';
import 'package:universy/system/locale.dart';
import 'package:universy/text/translators/milestones.dart';
import 'package:universy/widgets/buttons/uvsy/delete.dart';
import 'package:universy/widgets/paddings/edge.dart';

import 'card.dart';

class ExistingMilestoneWidget extends StatefulWidget {
  final Milestone milestone;
  final OnUpdateCommand onUpdateCommand;
  final OnDeleteCommand onDeleteCommand;
  final DateTimeRange dateTimeRange;

  const ExistingMilestoneWidget(
      {Key key,
      this.milestone,
      this.onUpdateCommand,
      this.onDeleteCommand,
      this.dateTimeRange})
      : super(key: key);

  @override
  _ExistingMilestoneWidgetState createState() =>
      _ExistingMilestoneWidgetState();
}

class _ExistingMilestoneWidgetState extends State<ExistingMilestoneWidget> {
  GlobalKey<FlipCardState> _cardKey;
  Milestone milestone;
  OnUpdateCommand onUpdateCommand;
  OnDeleteCommand onDeleteCommand;
  DateTime dateSelected;
  DateTimeRange dateTimeRange;

  @override
  void initState() {
    this._cardKey = GlobalKey<FlipCardState>();
    this.dateTimeRange = widget.dateTimeRange;
    this.milestone = widget.milestone;
    this.dateSelected = DateTime.now();
    this.onUpdateCommand = widget.onUpdateCommand;
    this.onDeleteCommand = widget.onDeleteCommand;
    super.initState();
  }

  @override
  void dispose() {
    this._cardKey = null;
    this.milestone = null;
    this.dateTimeRange = null;
    this.onUpdateCommand = null;
    this.onDeleteCommand = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      key: _cardKey,
      direction: FlipDirection.VERTICAL,
      front: _buildFrontSide(),
      back: _buildBackSide(),
    );
  }

  Widget _buildFrontSide() {
    return MilestoneCard(
      padding: 8,
      color: Color(0xffFFDC74),
      children: <Widget>[
        _buildFrontSideAvatar(),
        _buildFrontSideTextAndDate(),
      ],
    );
  }

  Widget _buildFrontSideAvatar() {
    return CircleAvatar(
      backgroundColor: Colors.white70,
      radius: 14.0,
      child: Center(
        child: Icon(Icons.done),
      ),
    );
  }

  Widget _buildFrontSideTextAndDate() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildMilestoneDisplayName(),
            _buildMilestoneDisplayDate(),
          ],
        ),
      ),
    );
  }

  Widget _buildMilestoneDisplayName() {
    var display = getMilestoneDisplayName(milestone.milestoneType);
    return Text(display, style: TextStyle(fontWeight: FontWeight.bold));
  }

  Widget _buildMilestoneDisplayDate() {
    DateFormat dateFormat =
        DateFormat("MMM yyyy", SystemLocale.getSystemLocale().toString());
    var display = dateFormat.format(milestone.date);
    return Text(display, style: TextStyle(color: Colors.black));
  }

  Widget _buildBackSide() {
    return MilestoneCard(
      color: Color(0xffffe7c2),
      padding: 8,
      children: <Widget>[
        _buildBackSideDateButton(),
        _buildBackSideDateText(),
        _buildBackSideDeleteButton(),
      ],
    );
  }

  Widget _buildBackSideDateButton() {
    return CircleAvatar(
      backgroundColor: Colors.white70,
      radius: 16.0,
      child: IconButton(
        padding: EdgeInsets.all(1.0),
        icon: Icon(
          Icons.date_range,
          color: Colors.black,
          size: 20.0,
        ),
        onPressed: _updateMilestone,
      ),
    );
  }

  Widget _buildBackSideDateText() {
    DateFormat dateFormat =
        DateFormat("MMM yyyy", SystemLocale.getSystemLocale().toString());
    var display = dateFormat.format(milestone.date);
    return FlatButton(
      padding: EdgeInsets.all(5.0),
      splashColor: Colors.amber,
      child: Text(
        display,
        style: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 16.0,
          color: Colors.black,
        ),
      ),
      onPressed: _updateMilestone,
    );
  }

  Widget _buildBackSideDeleteButton() {
    return Expanded(
      child: Container(
        alignment: Alignment.centerRight,
        child: _buildDeleteButton(),
      ),
    );
  }

  Widget _buildDeleteButton() {
    return CircleAvatar(
      backgroundColor: Colors.white70,
      radius: 21.0,
      child: DeleteButton(
        size: 20.0,
        onDelete: _deleteMilestone,
      ),
    );
  }

  void _deleteMilestone() {
    onDeleteCommand.perform();
  }

  void _updateMilestone() async {
    final picked = await showMonthPicker(
      context: context,
      initialDate: milestone.date,
      firstDate: widget.dateTimeRange.from,
      lastDate: widget.dateTimeRange.to,
    );

    if (picked != null && picked != dateSelected) {
      setState(() {
        this.dateSelected = picked;
      });
      onOkAction();
    }
  }

  void onOkAction() {
    onUpdateCommand.perform(dateSelected);
    _cardKey.currentState.toggleCard();
  }
}

typedef ExistingMilestoneOkAction = Function(DateTime dateTime);
