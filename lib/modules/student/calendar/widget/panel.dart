import 'package:flutter/material.dart';
import 'package:universy/model/student/event.dart';
import 'package:universy/modules/student/calendar/widget/existing_event.dart';
import 'package:universy/text/text.dart';
import 'package:universy/util/object.dart';

class EventsPanelWidget extends StatefulWidget {
  final List<StudentEvent> _events;

  const EventsPanelWidget({Key key, List<StudentEvent> events})
      : _events = events,
        super(key: key);

  @override
  _EventsPanelWidgetState createState() => _EventsPanelWidgetState();
}

class _EventsPanelWidgetState extends State<EventsPanelWidget> {
  List<StudentEvent> _events;

  @override
  void initState() {
    this._events = widget._events;
    super.initState();
  }

  @override
  void dispose() {
    this._events = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Icon(Icons.remove, size: 25.0, color: Colors.grey),
          Expanded(child: _buildListEvents(), flex: 8)
        ],
      ),
    );
  }

  Widget _buildListEvents() {
    if (notNull(widget._events) && widget._events.isNotEmpty) {
      return Container(
        color: Colors.white,
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: widget._events.map(_buildEvent).toList(),
        ),
      );
    } else {
      return _buildEmptyEvent();
    }
  }

  Widget _buildEmptyEvent() {
    return Container(
      padding: EdgeInsets.only(top: 25.0),
      alignment: Alignment.topCenter,
      child: Text(
        AppText.getInstance().get("student.calendar.events.emptyEventsDay"),
        style: TextStyle(fontSize: 17),
      ),
    );
  }

  Widget _buildEvent(StudentEvent event) {
    return ExistingEvent(event: event, onSave: _refreshEvents);
  }

  void _refreshEvents(StudentEvent event) {
    setState(() {
      var index =
          _events.indexWhere((element) => event.eventId == element.eventId);
      if (index != -1) {
        _events[index] = event;
      }
    });
  }
}
