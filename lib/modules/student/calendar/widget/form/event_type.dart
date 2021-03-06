import 'package:flutter/material.dart';
import 'package:universy/model/student/event.dart';

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
  List<EventTypeItem> _eventTypesItems;
  String _eventType;
  Function(String) _onChange;

  StudentEventTypeState(this._onChange, this._eventType);

  void initState(){
    this._eventTypesItems = EventTypeItem.getEventTypes();
    super.initState();
  }

  void handleOnSelect(String selectedEventType) {
    setState(() {
      _eventType = selectedEventType;
      _onChange(selectedEventType);
    });
  }

  Widget build(BuildContext context) {
    return GridView.count(
      physics: BouncingScrollPhysics(),
      crossAxisCount: 2,
      scrollDirection: Axis.horizontal,
      children: List.generate(
        _eventTypesItems.length,
        (index) => EventItemWidget(
          onSelect: handleOnSelect,
          selected: _eventTypesItems[index].eventType == _eventType,
          eventTypeItem: _eventTypesItems[index],
        ),
      ),
    );
  }
}

class EventItemWidget extends StatelessWidget {
  final EventTypeItem _eventTypeItem;
  final bool _selected;
  final Function(String) _onSelect;

  EventItemWidget(
      {Key key,
      @required EventTypeItem eventTypeItem,
      Function(String) onSelect,
      bool selected = false})
      : this._eventTypeItem = eventTypeItem,
        this._onSelect = onSelect,
        this._selected = selected,
        super(key: key);

  void handleTap() {
    _onSelect(_eventTypeItem.eventType);
  }

  @override
  Widget build(BuildContext context) {
    var iconColor = _selected ? Theme.of(context).highlightColor : Colors.grey;
    var textStyle = _selected
        ? TextStyle(fontWeight: FontWeight.bold)
        : TextStyle(color: Colors.grey);

    return InkWell(
      onTap: handleTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _eventTypeItem.iconData,
            color: iconColor,
            size: 36.0,
          ),
          SizedBox(
            height: 5,
          ),
          Center(
              child: Text(
            _eventTypeItem.description,
            style: textStyle,
            textAlign: TextAlign.center,
          ))
        ],
      ),
    );
  }
}
