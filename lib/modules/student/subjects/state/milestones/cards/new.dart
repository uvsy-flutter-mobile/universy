import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:optional/optional.dart';
import 'package:universy/business/correlatives/validator.dart';
import 'package:universy/model/time.dart';
import 'package:universy/modules/student/subjects/state/correlative_dialog.dart';
import 'package:universy/modules/student/subjects/state/milestones/commands/command.dart';

import 'card.dart';

class NewMilestoneWidget extends StatefulWidget {
  final String milestoneDisplayName;
  final bool available;
  final OnNewCommand onNewCommand;
  final DateTimeRange dateTimeRange;

  const NewMilestoneWidget(
      {Key key,
      this.milestoneDisplayName,
      this.available,
      this.onNewCommand,
      this.dateTimeRange})
      : super(key: key);

  @override
  _NewMilestoneWidgetState createState() => _NewMilestoneWidgetState();
}

class _NewMilestoneWidgetState extends State<NewMilestoneWidget> {
  String milestoneDisplayName;
  OnNewCommand onNewCommand;
  DateTime dateSelected;
  DateTimeRange dateTimeRange;

  @override
  void initState() {
    this.milestoneDisplayName = widget.milestoneDisplayName;
    this.onNewCommand = widget.onNewCommand;
    this.dateSelected = DateTime.now();
    this.dateTimeRange = widget.dateTimeRange;
    super.initState();
  }

  @override
  void dispose() {
    this.onNewCommand = null;
    this.dateTimeRange = null;
    this.dateSelected = null;
    this.milestoneDisplayName = null;
    super.dispose();
  }

  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.all(0),
      child: MilestoneCard(
        padding: 8,
        color: widget.available ? Color(0xfffaf0e1) : Colors.black12,
        children: <Widget>[
          _buildAvatar(),
          _buildMilestoneName(),
        ],
      ),
      onPressed: widget.available ? _updateMilestone : null,
    );
  }

  Widget _buildAvatar() {
    return CircleAvatar(
      backgroundColor: Colors.white70,
      radius: 14.0,
      child: Icon(widget.available ? Icons.add : Icons.lock_outline),
    );
  }

  Widget _buildMilestoneName() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildMilestoneDisplayName(),
          ],
        ),
      ),
    );
  }

  Widget _buildMilestoneDisplayName() {
    return Text(
      milestoneDisplayName,
      style: TextStyle(color: widget.available ? Colors.black : Colors.grey),
    );
  }

  void _updateMilestone() async {
    CorrelativeValidation correlativeValidation =
        onNewCommand.checkCorrelative();
    bool force = false;

    if (correlativeValidation.isNotValid) {
      force = await _showCorrelativeAndForceDialog(correlativeValidation);
    }

    if (correlativeValidation.isValid || (force ?? false)) {
      await _selectDateAndUpdate();
    }
  }

  Future<bool> _showCorrelativeAndForceDialog(
      CorrelativeValidation correlativeValidation) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) => CorrelativeRestrictionDialog(
        correlativeValidation: correlativeValidation,
      ),
    );
  }

  Future<void> _selectDateAndUpdate() async {
    final picked = await showMonthPicker(
      context: context,
      initialDate: Optional.ofNullable(widget.dateTimeRange) //
          .map((dt) => dt.from) //
          .orElse(dateSelected),
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
    onNewCommand.perform(dateSelected);
  }
}
