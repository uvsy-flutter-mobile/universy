import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:universy/model/student/event.dart';
import 'package:universy/modules/student/calendar/calendar.dart';
import 'package:universy/modules/student/notifications/event_widget.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/buttons/raised/rounded.dart';
import 'package:universy/widgets/buttons/uvsy/cancel.dart';
import 'package:universy/widgets/paddings/edge.dart';

class NotificationsDialog extends StatelessWidget {
  final List<StudentEvent> _events;

  const NotificationsDialog({Key key, List<StudentEvent> events})
      : _events = events,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: _buildShapeDialog(),
      content:
          SizedBox(width: double.maxFinite, child: _buildBodyDialog(context)),
      title: Text(AppText.getInstance().get("student.notifications.title"),
          textAlign: TextAlign.center),
      contentPadding: EdgeInsets.only(top: 3.0),
      actions: <Widget>[
        _buildNavigationToCalendar(context),
        CancelButton(onCancel: () => Navigator.of(context).pop())
      ],
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
        child: Text(
            AppText.getInstance()
                .get("student.notifications.actions.goToCalendar"),
            style: Theme.of(context).primaryTextTheme.button),
      ),
      color: Theme.of(context).buttonColor,
      radius: 10,
      onPressed: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => StudentCalendarModule())),
    );
  }

  Widget _buildBodyDialog(BuildContext context) {
    return StaggeredGridView.countBuilder(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 4,
      itemCount: _events.length,
      staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
      mainAxisSpacing: 2.0,
      crossAxisSpacing: 1.5,
      scrollDirection: Axis.vertical,
      itemBuilder: _eventsBuilder,
    );
  }

  Widget _eventsBuilder(BuildContext context, int index) {
    StudentEvent event = _events[index];
    return NotificationEventWidget(event: event);
  }
}
