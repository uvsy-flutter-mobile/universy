import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universy/business/converters/time.dart';
import 'package:universy/model/student/event.dart';
import 'package:universy/modules/student/notifications/notification_dialog.dart';
import 'package:universy/services/factory.dart';
import 'package:universy/util/object.dart';
import 'package:universy/widgets/future/future_widget.dart';

const String NO_NOTIFICATION = '0';

class NotificationsAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var sessionFactory = Provider.of<ServiceFactory>(context, listen: false);
    var studentEventService = sessionFactory.studentEventService();
    return FutureWidget(
      fromFuture:
          studentEventService.getStudentEvents(DateTime.now(), DateTime.now()),
      onData: (events) => _buildIconAlert(context, events),
    );
  }

  Widget _buildIconAlert(BuildContext context, List<StudentEvent> events) {
    List<StudentEvent> eventsToday =
        _validateNotEventsList(events) ? [] : _buildEventsSorted(events);
    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        _buildNotificationIcon(eventsToday, context),
        _buildQuantityNotification(eventsToday)
      ],
    );
  }

  List<StudentEvent> _buildEventsSorted(List<StudentEvent> events) {
    TimeOfDayIntConverter timeOfDayIntConverter = new TimeOfDayIntConverter();
    events?.sort((a, b) {
      int timeA = timeOfDayIntConverter.convertFromTimeOfDay(a.timeFrom);
      int timeB = timeOfDayIntConverter.convertFromTimeOfDay(b.timeFrom);
      return timeA.compareTo(timeB);
    });
    return events;
  }

  IconButton _buildNotificationIcon(
      List<StudentEvent> eventsToday, BuildContext context) {
    return IconButton(
        icon: Icon(Icons.notifications, size: 30.0, color: Colors.grey),
        splashColor: Colors.amberAccent,
        onPressed: () => _validateNotEventsList(eventsToday)
            ? {}
            : showDialog(
                context: context,
                builder: (context) =>
                    NotificationsDialog(events: eventsToday)));
  }

  bool _validateNotEventsList(List<StudentEvent> events) {
    return isNull(events) || events.isEmpty;
  }

  Widget _buildQuantityNotification(List<StudentEvent> eventsToday) {
    return Positioned(
      top: 2,
      right: 24,
      child: CircleAvatar(
        radius: 13.0,
        backgroundColor: _validateNotEventsList(eventsToday)
            ? Colors.grey[350]
            : Colors.amber,
        child: Text(
          _validateNotEventsList(eventsToday)
              ? NO_NOTIFICATION
              : eventsToday.length.toString(),
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
      ),
    );
  }
}
