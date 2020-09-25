import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:universy/business/converters/time.dart';
import 'package:universy/constants/notifications.dart';
import 'package:universy/model/student/event.dart';
import 'package:universy/modules/student/calendar/calendar.dart';
import 'package:universy/services/factory.dart';
import 'package:universy/widgets/buttons/raised/rounded.dart';
import 'package:universy/widgets/buttons/uvsy/cancel.dart';
import 'package:universy/widgets/future/future_widget.dart';
import 'package:universy/widgets/paddings/edge.dart';

class NotificationsAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var sessionFactory = Provider.of<ServiceFactory>(context, listen: false);
    var studentEventService =
        sessionFactory.studentEventService(); //TODO: check the dates
    return FutureWidget(
      fromFuture:
          studentEventService.getStudentEvents(DateTime.now(), DateTime.now()),
      onData: (events) => _buildIconAlert(context, events),
    );
  }

  Widget _buildIconAlert(BuildContext context, List<StudentEvent> events) {
    List<StudentEvent> eventsToday = _buildEventsSorted(events);
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
        icon: Icon(Icons.notifications, size: 35.0, color: Colors.grey),
        splashColor: Colors.amberAccent,
        onPressed: () => showDialog(
            context: context,
            builder: (context) => eventsToday.isEmpty
                ? {}
                : NotificationsDialog(events: eventsToday)));
  }

  Widget _buildQuantityNotification(List<StudentEvent> eventsToday) {
    return Positioned(
      top: 2,
      right: 23,
      child: CircleAvatar(
        radius: 14.0,
        backgroundColor: eventsToday.isEmpty ? Colors.grey : Colors.amber,
        child: Text(
          eventsToday.isEmpty ? NO_NOTIFICATION : eventsToday.length.toString(),
          style: TextStyle(color: Colors.white, fontSize: 18.0),
        ),
      ),
    );
  }
}

class NotificationsDialog extends StatelessWidget {
  final List<StudentEvent> _events;

  const NotificationsDialog({Key key, List<StudentEvent> events})
      : _events = events,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: _buildShapeDialog(),
      elevation: 80.0,
      content: _buildBodyDialog(_events),
      title: Text("Eventos del dia", textAlign: TextAlign.center),
      contentPadding: EdgeInsets.only(top: 10.0),
      actions: <Widget>[_buildNavigationToCalendar(context), CancelButton()],
    );
  }

  ShapeBorder _buildShapeDialog() {
    return RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0)));
  }

  Widget _buildNavigationToCalendar(BuildContext context) {
    return CircularRoundedRectangleRaisedButton.general(
      child: AllEdgePaddedWidget(
        padding: 12.0,
        child: Text("Ver Calendario",
            style: Theme.of(context).primaryTextTheme.button),
      ),
      color: Theme.of(context).buttonColor,
      radius: 10,
      onPressed: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => StudentCalendarModule())),
    );
  }

  Widget _buildBodyDialog(List<StudentEvent> events) {
    return StaggeredGridView.countBuilder(
      physics: BouncingScrollPhysics(),
      crossAxisCount: 4,
      itemCount: events.length,
      staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
      mainAxisSpacing: 2.0,
      crossAxisSpacing: 1.5,
      itemBuilder: _eventsBuilder,
    );
  }

  Widget _eventsBuilder(BuildContext context, int index) {
    StudentEvent event = _events[index];
    return Text("Hola");
  }
}
