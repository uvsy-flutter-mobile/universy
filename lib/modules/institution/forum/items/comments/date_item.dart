import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DateItem extends StatelessWidget {
  final DateTime _date;
  final bool _withTime;

  DateItem({Key key, DateTime date, bool withTime})
      : this._date = date,
        this._withTime = withTime,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    String date = _buildStringDate();
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text(
          date,
          style: TextStyle(color: Colors.grey, fontSize: 10),
        )
      ],
    );
  }

  String _buildStringDate() {
    String finalDate="";
    List<String> dateUnformat = this._date.toString().split(" ");
    List<String> dateSplitted = dateUnformat[0].split("-");
    String date = dateSplitted[2] + "/" + dateSplitted[1] + "/" + dateSplitted[0].substring(2, 4);
    if (_withTime==true) {
      String time = this._date.hour.toString() + ":" + this._date.minute.toString();
      finalDate = date + " a las " + time;
    }else{
      finalDate = date;
    }
    return finalDate;
  }
}
