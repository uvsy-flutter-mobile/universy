import 'package:flutter/material.dart';
import 'package:universy/model/student/schedule.dart';
import 'package:universy/modules/student/schedule/widgets/course_info.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/buttons/color/color_picker.dart';
import 'package:universy/widgets/cards/rectangular.dart';
import 'package:universy/widgets/paddings/edge.dart';

class ScratchCourseCard extends StatefulWidget {
  final ScheduleScratchCourse _scheduleScratchCourse;
  final Function(ScheduleScratchCourse) _onRemove;

  const ScratchCourseCard(
      {@required ScheduleScratchCourse scheduleScratchCourse,
      @required Function(ScheduleScratchCourse) onRemove})
      : this._scheduleScratchCourse = scheduleScratchCourse,
        this._onRemove = onRemove,
        super();

  @override
  State<StatefulWidget> createState() {
    return ScratchCourseCardState(this._scheduleScratchCourse, this._onRemove);
  }
}

class ScratchCourseCardState extends State<ScratchCourseCard> {
  ScheduleScratchCourse _scheduleScratchCourse;
  Function(ScheduleScratchCourse) _onRemove;

  ScratchCourseCardState(this._scheduleScratchCourse, this._onRemove);

  @override
  Widget build(BuildContext context) {
    return CircularRoundedRectangleCard(
        radius: 8,
        color: Colors.white,
        elevation: 2,
        child: Column(
          children: <Widget>[
            _buildCardHeader(context),
            Divider(
              height: 2,
            ),
            _buildCardContent()
          ],
        ));
  }

  Widget _buildCardHeader(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 9, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SymmetricEdgePaddingWidget.horizontal(
              paddingValue: 8.0,
              child: ColorPickerButton(
                initialColor: _scheduleScratchCourse.color,
                onSelectedColor: _onSelectedColor,
                radius: 15,
                iconSize: 18,
              ),
            ),
            Expanded(
                child: Text(
                  _scheduleScratchCourse.subjectName,
                  overflow: TextOverflow.visible,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                flex: 10),
            IconButton(
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              icon: Icon(Icons.clear),
              onPressed: () => _onRemove(_scheduleScratchCourse),
            )
          ],
        ));
  }

  void _onSelectedColor(Color newColor) {
    setState(() {
      _scheduleScratchCourse.color = newColor;
    });
  }

  Widget _buildCardContent() {
    return Container(
        padding: EdgeInsets.all(12),
        child: CourseInfoWidget(
          scratchCourse: _scheduleScratchCourse,
        ));
  }
}
