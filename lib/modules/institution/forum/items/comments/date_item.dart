import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universy/text/text.dart';

class DateItemWidget extends StatelessWidget {
  final DateTime _date;
  final bool _withTime;

  DateItemWidget({Key key, DateTime date, bool withTime})
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
    String finalDate = "";
    List<String> dateUnformat = this._date.toString().split(" ");
    List<String> dateSplitted = dateUnformat[0].split("-");
    String date = dateSplitted[2] + "/" + dateSplitted[1] + "/" + dateSplitted[0].substring(2, 4);
    if (_withTime == true) {
      String minute='';
      if(this._date.minute<10){minute='0${this._date.minute}';}else{minute=this._date.minute.toString();};
      String time = this._date.hour.toString() + ":" + minute;
      String separator = AppText.getInstance().get("institution.forum.comments.separator");
      finalDate = date + separator + time;
    } else {
      finalDate = date;
    }
    return finalDate;
  }
}
