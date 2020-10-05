import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:universy/constants/event_types.dart';
import 'package:universy/model/student/event.dart';
import 'package:universy/modules/student/calendar/bloc/table-calendar/cubit.dart';
import 'package:universy/modules/student/calendar/widget/form/form.dart';
import 'package:universy/services/factory.dart';
import 'package:universy/text/text.dart';
import 'package:universy/text/translators/event_type.dart';
import 'package:universy/widgets/async/modal.dart';
import 'package:universy/widgets/paddings/edge.dart';

class ExistingEvent extends StatelessWidget {
  final StudentEvent event;

  const ExistingEvent({Key key, StudentEvent event})
      : this.event = event,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      enabled: true,
      actionExtentRatio: 0.25,
      child: _buildEventCard(context),
      secondaryActions: <Widget>[_buildDeleteSlide(context)],
    );
  }

  Widget _buildEventCard(BuildContext context) {
    return GestureDetector(
      onTap: () => _buildEditEventForm(context),
      child: Container(
        decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 1, color: Color(0xFFC9C9C9))),
          color: Colors.white,
        ),
        child: _buildListTile(context),
      ),
    );
  }

  void _buildEditEventForm(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => StudentEventFormWidget(
            onConfirm: () => _refreshCalendar(context), studentEvent: event),
      ),
    );
  }

  Widget _buildListTile(BuildContext context) {
    return ListTile(
      leading: AllEdgePaddedWidget(
          padding: 5,
          child: Icon(
            EventType.getIcon(event.eventType),
          )),
      title: Text(
        EventTypeDescriptionTranslator().translate(event.eventType),
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
      trailing: Icon(
        Icons.keyboard_arrow_left,
        size: 38,
        color: Color(0xFFC9C9C9),
      ),
      subtitle: _buildEventTitle(context),
    );
  }

  Widget _buildEventTitle(BuildContext context) {
    String timeFrom = event.timeFrom.format(context);
    String timeTo = event.timeTo.format(context);
    String message = "${event.title} $timeFrom / $timeTo";
    return Text(message);
  }

  Widget _buildDeleteSlide(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: Color(0xFFC9C9C9))),
      ),
      child: _buildDeleteButton(context),
    );
  }

  Widget _buildDeleteButton(BuildContext context) {
    return IconSlideAction(
      color: Colors.red,
      icon: Icons.delete,
      onTap: () => _pressDeleteEventButton(context),
    );
  }

  void _pressDeleteEventButton(BuildContext context) async {
    await AsyncModalBuilder()
        .perform(_deleteEvents)
        .withTitle(
            AppText.getInstance().get("student.calendar.actions.deleting"))
        .then(_refreshCalendarAndNavigateBack)
        .build()
        .run(context);
  }

  Future _deleteEvents(BuildContext context) async {
    var sessionFactory = Provider.of<ServiceFactory>(context, listen: false);
    var studentEventService = sessionFactory.studentEventService();
    await studentEventService.deleteStudentEvent(this.event);
  }

  void _refreshCalendarAndNavigateBack(BuildContext context) {
    this._refreshCalendar(context);
  }

  void _refreshCalendar(BuildContext context) {
    TableCalendarCubit tableCalendarCubit =
        BlocProvider.of<TableCalendarCubit>(context);
    tableCalendarCubit.refreshTableCalendar(event.date);
  }
}
