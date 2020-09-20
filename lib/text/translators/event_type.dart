import 'package:universy/constants/strings.dart';
import 'package:universy/text/text.dart';
import 'package:universy/text/translator.dart';

class EventTypeDescriptionTranslator implements Translator<String> {
  String translate(String eventType) {
    try {
      return AppText.getInstance().get("student.calendar.eventType.$eventType");
    } catch (_) {
      return N_A;
    }
  }
}
