import 'package:flutter/material.dart';
import 'package:universy/model/student/event.dart';
import 'package:universy/modules/student/calendar/widget/existing-event-widget.dart';
import 'package:universy/text/text.dart';
import 'package:universy/util/object.dart';

class EventsPanelWidget extends StatelessWidget {
  final List<StudentEvent> _events;

  const EventsPanelWidget({Key key, List<StudentEvent> events})
      : _events = events,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFE8E8E8),
      child: Column(
        children: <Widget>[
          Icon(Icons.remove, size: 25.0, color: Colors.grey),
          Expanded(child: _buildListEvents(), flex: 8)
        ],
      ),
    );
  }

  Widget _buildListEvents() {
    if (notNull(_events) && _events.isNotEmpty) {
      return Container(
        color: Colors.white,
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: _events.map(_buildEvent).toList(),
        ),
      );
    } else {
      return _buildEmptyEvent();
    }
  }

  Widget _buildEmptyEvent() {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      alignment: Alignment.topCenter,
      child: Text(
        AppText.getInstance().get("student.calendar.events.emptyEventsDay"),
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildEvent(StudentEvent event) {
    return ExistingEvent(event: event);
  }
}
