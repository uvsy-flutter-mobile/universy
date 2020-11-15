import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:universy/app/theme.dart';
import 'package:universy/constants/routes.dart';
import 'package:universy/modules/institution/forum/bloc/states.dart';
import 'package:universy/modules/institution/forum/forum.dart';
import 'package:universy/modules/institution/dashboard/course/dashboard.dart';
import 'package:universy/modules/institution/dashboard/subjects/dashboard.dart';
import 'package:universy/modules/loading/loading.dart';
import 'package:universy/modules/main/main.dart';
import 'package:universy/modules/student/calendar/calendar.dart';
import 'package:universy/modules/student/enroll/enroll.dart';
import 'package:universy/modules/student/notes/notes.dart';
import 'package:universy/modules/student/profile/profile.dart';
import 'package:universy/modules/student/profile/update.dart';
import 'package:universy/system/config.dart';
import 'package:universy/system/locale.dart';
import 'package:universy/system/start.dart';
import 'package:universy/widgets/future/future_widget.dart';

class Universy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [SystemLocale.getSystemLocale()],
      //title: _getApplicationTitle(),
      theme: uvsyTheme,
      home: FutureWidget(
        fromFuture: SystemStart.getWidget(context),
        onData: (home) => home,
        onMeanTime: LoadingModule(),
      ),
      routes: _getApplicationRoutes(),
    );
  }

  Map<String, WidgetBuilder> _getApplicationRoutes() {
    return {
      Routes.HOME: (context) => MainModule(),
      Routes.CAREER_ENROLL: (context) => CareerEnrollModule(),
      Routes.NOTES_MODULE: (context) => NotesModule(),
      Routes.CALENDAR_MODULE: (context) => StudentCalendarModule(),
      Routes.SUBJECT_BOARD_MODULE: (context) => SubjectBoardModule(),
      Routes.COURSE_BOARD_MODULE: (context) => CourseBoardModule(),
      Routes.FORUM_MODULE: (context) => InstitutionForumModule(),
    };
  }

  String _getApplicationTitle() {
    String stage = SystemConfig.instance().getStage();
    return "Universy [$stage]";
  }
}
