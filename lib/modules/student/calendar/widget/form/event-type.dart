import 'package:flutter/material.dart';
import 'package:optional/optional_internal.dart';
import 'package:universy/model/student/event.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/formfield/decoration/builder.dart';
import 'package:universy/widgets/formfield/text/custom.dart';
import 'package:universy/widgets/formfield/text/validators.dart';
import 'package:universy/widgets/paddings/edge.dart';

class StudentEventTypeWidget extends StatefulWidget {
  final Function(String) onChange;
  final String eventType;

  const StudentEventTypeWidget({Key key, this.onChange, this.eventType})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return StudentEventTypeState(onChange, eventType);
  }
}

class StudentEventTypeState extends State<StudentEventTypeWidget> {
  Key _key;
  List<EventTypeDescription> _eventTypesDescription;
  String _eventType;
  Function(String) _onChange;

  StudentEventTypeState(this._onChange, this._eventType);

  @override
  void didChangeDependencies() {
    print(this._eventType);
    this._eventTypesDescription = EventTypeDescription.getEventTypes();
    super.didChangeDependencies();
  }

  void handleOnSelect(String selectedEventType) {
    setState(() {
      _eventType = selectedEventType;
      _onChange(selectedEventType);
    });
  }

  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      scrollDirection: Axis.horizontal,
      children: List.generate(
          _eventTypesDescription.length,
          (index) => EventItemWidget(
              onSelect: handleOnSelect,
              selected: _eventTypesDescription[index].eventType == _eventType,
              eventTypeDescription: _eventTypesDescription[index])),
    );
  }

//  Widget build(BuildContext context) {
//    return GestureDetector(
//        onTap: () async {
//          TimeOfDay picked = await showTimePicker(
//            context: context,
//            initialTime: TimeOfDay.now(),
//            builder: (BuildContext context, Widget child) {
//              return MediaQuery(
//                data: MediaQuery.of(context)
//                    .copyWith(alwaysUse24HourFormat: true),
//                child: child,
//              );
//            },
//          );
//        },
//        child: Text(
//          "SetTime",
//          textAlign: TextAlign.center,
//        ));
//  }
}

class EventItemWidget extends StatelessWidget {
  final EventTypeDescription _eventTypeDescription;
  final bool _selected;
  final Function(String) _onSelect;

  EventItemWidget(
      {Key key,
      @required EventTypeDescription eventTypeDescription,
      Function(String) onSelect,
      bool selected = false})
      : this._eventTypeDescription = eventTypeDescription,
        this._onSelect = onSelect,
        this._selected = selected,
        super(key: key);

  void handleTap() {
    _onSelect(_eventTypeDescription.eventType);
  }

  @override
  Widget build(BuildContext context) {
    var iconColor = _selected ? Colors.amber : Colors.grey;
    var textStyle = _selected
        ? TextStyle(fontWeight: FontWeight.bold)
        : TextStyle(color: Colors.grey);

    return SizedBox(
      height: 100,
      child: InkWell(
        onTap: handleTap,
        child: Column(
          children: [
            Icon(
              _eventTypeDescription.iconData,
              color: iconColor,
              size: 60.0,
            ),
            Text(_eventTypeDescription.description, style: textStyle)
          ],
        ),
      ),
    );
  }
}
