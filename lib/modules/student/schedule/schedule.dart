import 'package:flutter/material.dart';
import 'package:universy/modules/student/schedule/schedule_list.dart';
import 'package:universy/system/assets.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/decorations/box.dart';

class StudentScheduleModule extends StatefulWidget {
  @override
  _StudentScheduleModuleState createState() => _StudentScheduleModuleState();
}

class _StudentScheduleModuleState extends State<StudentScheduleModule> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          AppText.getInstance().get("student.schedule.title"),
        ),
      ),
      body: Container(
        decoration: assetImageDecoration(Assets.UNIVERSY_CITY_BACKGROUND),
        child: StudentScheduleListWidget(),
      ),
    );
  }
}
