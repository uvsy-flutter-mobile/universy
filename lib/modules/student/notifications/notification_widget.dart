import 'package:flutter/material.dart';
import 'package:universy/constants/event_types.dart';
import 'package:universy/model/student/event.dart';
import 'package:universy/text/translators/event_type.dart';
import 'package:universy/widgets/paddings/edge.dart';

class NotificationEventWidget extends StatelessWidget {
  final StudentEvent _event;

  const NotificationEventWidget({Key key, StudentEvent event})
      : _event = event,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AllEdgePaddedWidget(
      padding: 8.0,
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.deepPurple,
              width: 2.0,
            )),
        child: CircleAvatar(
          child: _createEventWidget(context),
          backgroundColor: Colors.white70,
          radius: 50.0,
        ),
      ),
    );
  }

  Widget _createEventWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildEventIcon(),
        SizedBox(
          height: 5,
        ),
        Center(child: _buildEventTitle(context)),
        SizedBox(
          height: 5,
        ),
        _buildEventTime(context),
      ],
    );
  }

  Widget _buildEventIcon() {
    return Icon(
      EventType.getIcon(_event.eventType),
      color: Colors.amber,
      size: 36.0,
    );
  }

  Widget _buildEventTitle(BuildContext context) {
    return Text(
      EventTypeDescriptionTranslator().translate(_event.eventType),
      style: Theme.of(context).primaryTextTheme.caption,
      textAlign: TextAlign.center,
      overflow: TextOverflow.clip,
    );
  }

  Widget _buildEventTime(BuildContext context) {
    String timeFrom = _event.timeFrom.format(context);
    return Center(
        child: Text(
      "$timeFrom",
      style: Theme.of(context).primaryTextTheme.caption,
      textAlign: TextAlign.center,
    ));
  }
}
