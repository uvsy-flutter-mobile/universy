import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:universy/app/theme.dart';
import 'package:universy/constants/routes.dart';
import 'package:universy/modules/loading/loading.dart';
import 'package:universy/modules/main/main.dart';
import 'package:universy/modules/student/calendar/calendar.dart';
import 'package:universy/services/factory.dart';
import 'package:universy/modules/student/enroll/enroll.dart';
import 'package:universy/modules/student/notes/notes.dart';
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
      Routes.CALENDAR_MODULE: (context) =>
          wrap(context, StudentCalendarModule()),
    };
  }

  //TODO: Remove wrap function
  Widget wrap(BuildContext context, Widget widget) {
    var serviceFactory = Provider.of<ServiceFactory>(context, listen: false);
    return Provider<ServiceFactory>.value(
      value: serviceFactory,
      child: widget,
    );
  }

  String _getApplicationTitle() {
    String stage = SystemConfig.instance().getStage();
    return "Universy [$stage]";
  }
}
